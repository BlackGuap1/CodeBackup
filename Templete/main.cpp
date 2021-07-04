// #include <iostream>
// #include <functional>   // std::function 函数容器头文件
// #include <thread>       // 线程头文件
// #include <mutex>        // mutex相关头文件
// #include <future>       // future相关头文件
// #include <chrono>
// #include <condition_variable>
// #include <queue>
#include "head.h"

void log(std::string str)
{
    time_t nowtime;
    struct tm* p;
    time(&nowtime);

    p = localtime(&nowtime);

    std::cout << p->tm_hour << ":" << p->tm_min << ":" << p->tm_sec << ", " << str << std::endl;
}

int main() {
    std::queue<int> produced_nums;
    std::mutex mtx;
    std::condition_variable cv;
    bool notified = false;  // 通知信号

    // 生产者
    auto producer = [&]() {
        for (int i = 0; ; i++) {
            char str[28];
            sprintf(str, "lebe into producer i: %d", i);
            log(str);
            std::this_thread::sleep_for(std::chrono::milliseconds(900));
            std::unique_lock<std::mutex> lock(mtx);
            std::cout << "producing " << i << std::endl;
            produced_nums.push(i);
            notified = true;
            cv.notify_all(); // 此处也可以使用 notify_one
        }
    };
    // 消费者
    auto consumer = [&](int id) {
        while (true) {
            std::cout << "lebe into consumer, id: " << id << std::endl;
            std::unique_lock<std::mutex> lock(mtx);
            while (!notified) {  // 避免虚假唤醒
                std::cout << "lebe wait for notify, id: " << id << std::endl;
                cv.wait(lock);
            }
            // 短暂取消锁，使得生产者有机会在消费者消费空前继续生产
            char str[32];
            sprintf(str, "lebe consumer pre_unlock, id: %d", id);
            log(str);
            lock.unlock();
            sprintf(str, "lebe consumer aft_unlock, id: %d", id);
            log(str);
            std::this_thread::sleep_for(std::chrono::milliseconds(1000)); // 消费者慢于生产者
            lock.lock();
            while (!produced_nums.empty()) {
                std::cout << "consuming " << produced_nums.front() << ", id: " << id << std::endl;
                produced_nums.pop();
            }
            notified = false;
        }
    };

    // 分别在不同的线程中运行
    std::thread p(producer);
    std::thread cs[2];
    for (int i = 0; i < 2; ++i) {
        cs[i] = std::thread(consumer, i);
    }
    p.join();
    for (int i = 0; i < 2; ++i) {
        cs[i].join();
    }
    return 0;
}