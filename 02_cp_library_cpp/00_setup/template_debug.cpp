#include <bits/stdc++.h>
using namespace std;

using ll = long long;
#define all(x) (x).begin(), (x).end()
#define sz(x) ((int)(x).size())

#ifdef LOCAL
#define debug(...) cerr << "[" << #__VA_ARGS__ << "]:", dbg(__VA_ARGS__)
template <typename T> void dbg(const T& x) { cerr << ' ' << x << endl; }
template <typename T, typename... R> void dbg(const T& x, const R&... r) { cerr << ' ' << x << ','; dbg(r...); }
#else
#define debug(...)
#endif

void solve() {

}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    int t = 1;
    cin >> t;
    while (t--) solve();
    return 0;
}
// Compile locally with: g++ -std=c++17 -O2 -DLOCAL -Wall -o out.exe file.cpp
