#ifndef SAMPLE_LIB_CONCAT_HPP
#define SAMPLE_LIB_CONCAT_HPP

#include <string>

namespace sample_lib {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string;
}  // namespace sample_lib

#endif