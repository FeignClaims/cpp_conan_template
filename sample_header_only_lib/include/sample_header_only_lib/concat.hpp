#ifndef SAMPLE_HEADER_ONLY_LIB_CONCAT_HPP
#define SAMPLE_HEADER_ONLY_LIB_CONCAT_HPP

#include <string>

namespace sample_header_only_lib {
[[nodiscard]] inline auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string {
  return lhs + rhs;
}
}  // namespace sample_header_only_lib

#endif