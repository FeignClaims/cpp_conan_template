#ifndef SAMPLE_APP_CONCAT_HPP
#define SAMPLE_APP_CONCAT_HPP

#include <string>

namespace sample_app {
[[nodiscard]] auto concat(std::string const& lhs, std::string const& rhs) noexcept(false) -> std::string;
}  // namespace sample_app

#endif