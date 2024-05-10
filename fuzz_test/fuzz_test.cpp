#include <cstdint>
#include <iterator>

#include <fmt/format.h>

[[nodiscard]] constexpr auto sum_values(uint8_t const* data, size_t size) -> int {
  constexpr int scale{1000};

  int value{};
  for (std::size_t offset = 0; offset < size; ++offset) {
    value += static_cast<int>(*std::next(data, static_cast<std::int64_t>(offset))) * scale;
  }
  return value;
}

// Fuzzer that attempts to invoke undefined behavior for signed integer overflow
extern "C" auto LLVMFuzzerTestOneInput(uint8_t const* data, size_t size) -> int {
  fmt::print("Value sum: {}, len{}\n", sum_values(data, size), size);
  return 0;
}