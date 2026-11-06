# Compile flags (Windows / MinGW g++)

- Normal:  `g++ -std=c++17 -O2 -Wall -o out.exe file.cpp`
- Local debug: `g++ -std=c++17 -O2 -DLOCAL -Wall -Wextra -o out.exe file.cpp`
- Sanitizers (works best on WSL/Linux): `-fsanitize=address,undefined -g`
