#include <future>
#include <iostream>

#include <boost/interprocess/detail/atomic.hpp>
#include <boost/smart_ptr/detail/spinlock.hpp>

volatile uint32_t value = 0;

int no_sync(bool inc, int limit)
{
  std::cout << "Started " << inc << " " << limit << std::endl;
  for (int i = 0; i < limit; ++i) {
    if (inc) {
      ++value;
    } else {
      --value;
    }
  }
  return 0;
}

int atomic(bool inc, int limit)
{
  std::cout << "Started " << inc << " " << limit << std::endl;
  for (int i = 0; i < limit; ++i) {
    if (inc) {
      boost::interprocess::ipcdetail::atomic_inc32(&value);
    } else {
      boost::interprocess::ipcdetail::atomic_dec32(&value);
    }
  }
  return 0;
}

static boost::detail::spinlock s;
int spinlock(bool inc, int limit)
{
  std::cout << "Started " << inc << " " << limit << std::endl;
  for (int i = 0; i < limit; ++i) {
    std::lock_guard<boost::detail::spinlock> guard(s);
    if (inc) {
      ++value;
    } else {
      --value;
    }
  }
  return 0;
}

static std::mutex m;
int mutex(bool inc, int limit)
{
  std::cout << "Started " << inc << " " << limit << std::endl;
  for (int i = 0; i < limit; ++i) {
    std::lock_guard<std::mutex> guard(m);
    if (inc) {
      ++value;
    } else {
      --value;
    }
  }
  return 0;
}

template <class T>
void loop(T t)
{
  const size_t N = 2000000;
  auto f = std::async(std::launch::async, std::bind(t, true, N));
  t(false, N / 2);
  f.wait();
  std::cout << value << std::endl;
}

int main(int argc, char **argv)
{
  if (argc > 1) {
    const std::string type = argv[1];
    if (type == "atomic")
      loop(atomic);
    else if (type == "spinlock")
      loop(spinlock);
    else if (type == "mutex")
      loop(mutex);
    else
      loop(no_sync);
    return 0;
  }

  return 1;
}


