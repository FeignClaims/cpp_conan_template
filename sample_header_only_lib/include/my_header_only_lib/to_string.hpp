#ifndef SAMPLE_HEADER_ONLY_LIB_SORT_HPP
#define SAMPLE_HEADER_ONLY_LIB_SORT_HPP

#include <string>

#include <fmt/core.h>
#include <fmt/format.h>

namespace sample_header_only_lib {
/**
 * Format a range's elements to `std::string` which is delimited by `", "`
 * 
 * @param[in] range The range to be formatted.
 * @return std::string The format string.
 */
[[nodiscard]] auto to_string(std::ranges::range auto&& range) -> std::string {
  return fmt::format("{}", fmt::join(range, ", "));
}
}  // namespace sample_header_only_lib

#endif