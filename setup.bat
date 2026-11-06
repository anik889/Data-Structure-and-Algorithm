@echo off
setlocal EnableDelayedExpansion
rem ================================================================
rem  setup.bat - builds the dsa-cp-library folder structure (cmd only)
rem  Put this file in the ROOT of your cloned repo and double-click it,
rem  or run:  setup.bat
rem  Safe to re-run: existing files are never overwritten.
rem ================================================================
cd /d "%~dp0"
set /a created=0
set /a skipped=0
set "mode=1"

rem find the line where the data section starts, then read everything after it
for /f "delims=:" %%N in ('findstr /n /b /c:"::DATA" "%~f0"') do set "skipn=%%N"
for /f "skip=%skipn% delims=" %%L in ('findstr /n "^" "%~f0"') do (
    set "ln=%%L"
    set "ln=!ln:*:=!"
    call :process
)

echo.
echo Done. Created !created! files, skipped !skipped! existing ones.
echo Next:  git add .
echo        git commit -m "Add DSA + CP library structure"
echo        git push
exit /b 0

:process
if "!mode!"=="2" goto :writeline
if "!mode!"=="3" goto :skipline
if not defined ln exit /b
if "!ln:~0,2!"==";;" goto :makestub
if "!ln:~0,7!"=="@@FILE " goto :startfile
exit /b

:writeline
if "!ln!"=="@@END" set "mode=1" & exit /b
>>"!cur!" echo(!ln!
exit /b

:skipline
if "!ln!"=="@@END" set "mode=1"
exit /b

:startfile
set "cur=!ln:~7!"
set "cur=!cur:/=\!"
call :ensuredir "!cur!"
if exist "!cur!" (
    set /a skipped+=1
    set "mode=3"
) else (
    set /a created+=1
    set "mode=2"
    type nul > "!cur!"
)
exit /b

:makestub
set "p=!ln:~2!"
set "p=!p:/=\!"
if "!p:~-1!"=="\" goto :makedir
call :ensuredir "!p!"
if exist "!p!" (
    set /a skipped+=1
    exit /b
)
set /a created+=1
for %%A in ("!p!") do (
    set "n=%%~nA"
    set "x=%%~xA"
)
set "t=!n:_= !"
if /i "!x!"==".c" call :stubc
if /i "!x!"==".cpp" call :stubcpp
if /i "!x!"==".md" call :stubmd
if not exist "!p!" type nul > "!p!"
exit /b

:makedir
if not exist "!p!" mkdir "!p!"
if not exist "!p!.gitkeep" type nul > "!p!.gitkeep"
exit /b

:ensuredir
if not exist "%~dp1" mkdir "%~dp1"
exit /b

:stubc
>"!p!" echo(/*
>>"!p!" echo( * Topic      : !t!
>>"!p!" echo( * Description:
>>"!p!" echo( * Complexity :
>>"!p!" echo( * Usage      :
>>"!p!" echo( */
>>"!p!" echo(#include ^<stdio.h^>
>>"!p!" echo(#include ^<stdlib.h^>
>>"!p!" echo(
>>"!p!" echo(int main^(void^) {
>>"!p!" echo(    return 0;
>>"!p!" echo(}
exit /b

:stubcpp
>"!p!" echo(// Topic      : !t!
>>"!p!" echo(// Description:
>>"!p!" echo(// Complexity : time O^(?^), space O^(?^)
>>"!p!" echo(// Usage      :
>>"!p!" echo(// Problem link:
>>"!p!" echo(#include ^<bits/stdc++.h^>
>>"!p!" echo(using namespace std;
>>"!p!" echo(
exit /b

:stubmd
>"!p!" echo(# !t!
>>"!p!" echo(
exit /b

::DATA
;;01_academic_ds_c/01_basics/pointers_and_memory.c
;;01_academic_ds_c/01_basics/structures_unions.c
;;01_academic_ds_c/01_basics/dynamic_memory.c
;;01_academic_ds_c/01_basics/recursion.c
;;01_academic_ds_c/01_basics/complexity_analysis.md
;;01_academic_ds_c/02_arrays/array_operations.c
;;01_academic_ds_c/02_arrays/2d_array_matrix.c
;;01_academic_ds_c/02_arrays/sparse_matrix.c
;;01_academic_ds_c/02_arrays/dynamic_array.c
;;01_academic_ds_c/03_strings/string_functions.c
;;01_academic_ds_c/03_strings/pattern_matching_naive.c
;;01_academic_ds_c/03_strings/palindrome_anagram.c
;;01_academic_ds_c/04_linked_list/singly.c
;;01_academic_ds_c/04_linked_list/doubly.c
;;01_academic_ds_c/04_linked_list/circular.c
;;01_academic_ds_c/04_linked_list/reverse_detect_cycle.c
;;01_academic_ds_c/04_linked_list/polynomial_addition.c
;;01_academic_ds_c/05_stack/array_stack.c
;;01_academic_ds_c/05_stack/linked_stack.c
;;01_academic_ds_c/05_stack/infix_postfix.c
;;01_academic_ds_c/05_stack/postfix_evaluation.c
;;01_academic_ds_c/05_stack/balanced_parentheses.c
;;01_academic_ds_c/06_queue/linear_queue.c
;;01_academic_ds_c/06_queue/circular_queue.c
;;01_academic_ds_c/06_queue/deque.c
;;01_academic_ds_c/06_queue/priority_queue.c
;;01_academic_ds_c/06_queue/queue_using_stacks.c
;;01_academic_ds_c/07_trees/binary_tree_traversals.c
;;01_academic_ds_c/07_trees/bst.c
;;01_academic_ds_c/07_trees/avl_tree.c
;;01_academic_ds_c/07_trees/red_black_tree.c
;;01_academic_ds_c/07_trees/threaded_tree.c
;;01_academic_ds_c/07_trees/heap_min_max.c
;;01_academic_ds_c/07_trees/trie.c
;;01_academic_ds_c/07_trees/b_tree.c
;;01_academic_ds_c/07_trees/expression_tree.c
;;01_academic_ds_c/08_graphs/adjacency_matrix.c
;;01_academic_ds_c/08_graphs/adjacency_list.c
;;01_academic_ds_c/08_graphs/bfs_dfs.c
;;01_academic_ds_c/08_graphs/dijkstra.c
;;01_academic_ds_c/08_graphs/bellman_ford.c
;;01_academic_ds_c/08_graphs/floyd_warshall.c
;;01_academic_ds_c/08_graphs/prim.c
;;01_academic_ds_c/08_graphs/kruskal_dsu.c
;;01_academic_ds_c/08_graphs/topological_sort.c
;;01_academic_ds_c/09_sorting/bubble_selection_insertion.c
;;01_academic_ds_c/09_sorting/merge_sort.c
;;01_academic_ds_c/09_sorting/quick_sort.c
;;01_academic_ds_c/09_sorting/heap_sort.c
;;01_academic_ds_c/09_sorting/counting_radix_bucket.c
;;01_academic_ds_c/09_sorting/shell_sort.c
;;01_academic_ds_c/10_searching_hashing/linear_binary_search.c
;;01_academic_ds_c/10_searching_hashing/interpolation_search.c
;;01_academic_ds_c/10_searching_hashing/hash_table_chaining.c
;;01_academic_ds_c/10_searching_hashing/hash_table_open_addressing.c
;;01_academic_ds_c/11_file_handling/file_io_records.c
;;01_academic_ds_c/12_mini_projects/order_management_linked_list.c
;;01_academic_ds_c/12_mini_projects/warehouse_robot_sim.c
;;01_academic_ds_c/12_mini_projects/student_record_system.c
;;01_academic_ds_c/12_mini_projects/library_management.c

;;02_cp_library_cpp/00_setup/stress_test/gen.cpp
;;02_cp_library_cpp/00_setup/stress_test/brute.cpp
;;02_cp_library_cpp/00_setup/stress_test/sol.cpp
;;02_cp_library_cpp/01_stl_cheatsheet/containers.md
;;02_cp_library_cpp/01_stl_cheatsheet/algorithms.md
;;02_cp_library_cpp/01_stl_cheatsheet/bitset_tricks.cpp
;;02_cp_library_cpp/01_stl_cheatsheet/custom_comparators_hash.cpp
;;02_cp_library_cpp/01_stl_cheatsheet/pbds_ordered_set.cpp
;;02_cp_library_cpp/02_math/modular_arithmetic.cpp
;;02_cp_library_cpp/02_math/gcd_lcm_extended_euclid.cpp
;;02_cp_library_cpp/02_math/sieve_linear_segmented.cpp
;;02_cp_library_cpp/02_math/prime_factorization.cpp
;;02_cp_library_cpp/02_math/miller_rabin_pollard_rho.cpp
;;02_cp_library_cpp/02_math/euler_totient_mobius.cpp
;;02_cp_library_cpp/02_math/ncr_factorials_lucas.cpp
;;02_cp_library_cpp/02_math/catalan_stirling_bell.cpp
;;02_cp_library_cpp/02_math/crt_chinese_remainder.cpp
;;02_cp_library_cpp/02_math/matrix_exponentiation.cpp
;;02_cp_library_cpp/02_math/gaussian_elimination.cpp
;;02_cp_library_cpp/02_math/fft_ntt.cpp
;;02_cp_library_cpp/02_math/xor_basis_gauss.cpp
;;02_cp_library_cpp/02_math/discrete_log_primitive_root.cpp
;;02_cp_library_cpp/02_math/big_integer.cpp
;;02_cp_library_cpp/02_math/fraction_complex.cpp
;;02_cp_library_cpp/02_math/inclusion_exclusion.cpp
;;02_cp_library_cpp/02_math/number_theory_tricks.md
;;02_cp_library_cpp/03_data_structures/dsu_rollback.cpp
;;02_cp_library_cpp/03_data_structures/fenwick_bit_1d_2d.cpp
;;02_cp_library_cpp/03_data_structures/segment_tree_basic.cpp
;;02_cp_library_cpp/03_data_structures/segment_tree_lazy.cpp
;;02_cp_library_cpp/03_data_structures/segment_tree_persistent.cpp
;;02_cp_library_cpp/03_data_structures/segment_tree_merge_sort_tree.cpp
;;02_cp_library_cpp/03_data_structures/segment_tree_beats.cpp
;;02_cp_library_cpp/03_data_structures/sparse_table_rmq.cpp
;;02_cp_library_cpp/03_data_structures/sqrt_decomposition_mos.cpp
;;02_cp_library_cpp/03_data_structures/mos_algorithm_with_updates.cpp
;;02_cp_library_cpp/03_data_structures/monotonic_stack_queue.cpp
;;02_cp_library_cpp/03_data_structures/sliding_window_deque.cpp
;;02_cp_library_cpp/03_data_structures/treap_implicit.cpp
;;02_cp_library_cpp/03_data_structures/splay_tree.cpp
;;02_cp_library_cpp/03_data_structures/li_chao_tree.cpp
;;02_cp_library_cpp/03_data_structures/convex_hull_trick.cpp
;;02_cp_library_cpp/03_data_structures/wavelet_tree.cpp
;;02_cp_library_cpp/03_data_structures/kd_tree.cpp
;;02_cp_library_cpp/03_data_structures/trie_binary_xor.cpp
;;02_cp_library_cpp/03_data_structures/order_statistic_tree.cpp
;;02_cp_library_cpp/04_graph/bfs_dfs_01bfs.cpp
;;02_cp_library_cpp/04_graph/dijkstra_spfa_bellman.cpp
;;02_cp_library_cpp/04_graph/floyd_warshall.cpp
;;02_cp_library_cpp/04_graph/mst_kruskal_prim_boruvka.cpp
;;02_cp_library_cpp/04_graph/topological_sort_kahn.cpp
;;02_cp_library_cpp/04_graph/scc_tarjan_kosaraju.cpp
;;02_cp_library_cpp/04_graph/bridges_articulation_points.cpp
;;02_cp_library_cpp/04_graph/bcc_block_cut_tree.cpp
;;02_cp_library_cpp/04_graph/lca_binary_lifting_euler.cpp
;;02_cp_library_cpp/04_graph/hld_heavy_light.cpp
;;02_cp_library_cpp/04_graph/centroid_decomposition.cpp
;;02_cp_library_cpp/04_graph/tree_diameter_rerooting.cpp
;;02_cp_library_cpp/04_graph/dsu_on_tree_small_to_large.cpp
;;02_cp_library_cpp/04_graph/euler_tour_flatten.cpp
;;02_cp_library_cpp/04_graph/two_sat.cpp
;;02_cp_library_cpp/04_graph/bipartite_check_matching.cpp
;;02_cp_library_cpp/04_graph/hopcroft_karp.cpp
;;02_cp_library_cpp/04_graph/hungarian.cpp
;;02_cp_library_cpp/04_graph/max_flow_dinic.cpp
;;02_cp_library_cpp/04_graph/min_cost_max_flow.cpp
;;02_cp_library_cpp/04_graph/euler_path_circuit.cpp
;;02_cp_library_cpp/04_graph/cycle_detection_functional_graph.cpp
;;02_cp_library_cpp/04_graph/tree_isomorphism_hashing.cpp
;;02_cp_library_cpp/05_dp/classic_knapsack_lis_lcs.cpp
;;02_cp_library_cpp/05_dp/coin_change_partition.cpp
;;02_cp_library_cpp/05_dp/bitmask_dp_tsp.cpp
;;02_cp_library_cpp/05_dp/digit_dp.cpp
;;02_cp_library_cpp/05_dp/dp_on_trees.cpp
;;02_cp_library_cpp/05_dp/dp_on_dag_grid.cpp
;;02_cp_library_cpp/05_dp/sos_dp_subset_sum.cpp
;;02_cp_library_cpp/05_dp/profile_broken_dp.cpp
;;02_cp_library_cpp/05_dp/interval_dp.cpp
;;02_cp_library_cpp/05_dp/probability_expected_value_dp.cpp
;;02_cp_library_cpp/05_dp/knuth_divide_conquer_opt.cpp
;;02_cp_library_cpp/05_dp/convex_hull_dp_opt.cpp
;;02_cp_library_cpp/05_dp/matrix_expo_dp.cpp
;;02_cp_library_cpp/05_dp/dp_patterns.md
;;02_cp_library_cpp/06_strings/prefix_function_kmp.cpp
;;02_cp_library_cpp/06_strings/z_function.cpp
;;02_cp_library_cpp/06_strings/hashing_single_double.cpp
;;02_cp_library_cpp/06_strings/manacher.cpp
;;02_cp_library_cpp/06_strings/trie.cpp
;;02_cp_library_cpp/06_strings/aho_corasick.cpp
;;02_cp_library_cpp/06_strings/suffix_array_lcp.cpp
;;02_cp_library_cpp/06_strings/suffix_automaton.cpp
;;02_cp_library_cpp/06_strings/suffix_tree.cpp
;;02_cp_library_cpp/06_strings/palindromic_tree_eertree.cpp
;;02_cp_library_cpp/06_strings/lyndon_booth_min_rotation.cpp
;;02_cp_library_cpp/06_strings/string_tricks.md
;;02_cp_library_cpp/07_geometry/point_vector_basics.cpp
;;02_cp_library_cpp/07_geometry/line_segment_intersection.cpp
;;02_cp_library_cpp/07_geometry/polygon_area_point_in_polygon.cpp
;;02_cp_library_cpp/07_geometry/convex_hull.cpp
;;02_cp_library_cpp/07_geometry/closest_pair_of_points.cpp
;;02_cp_library_cpp/07_geometry/rotating_calipers.cpp
;;02_cp_library_cpp/07_geometry/half_plane_intersection.cpp
;;02_cp_library_cpp/07_geometry/circle_operations.cpp
;;02_cp_library_cpp/07_geometry/sweep_line.cpp
;;02_cp_library_cpp/07_geometry/geometry_3d_basics.cpp
;;02_cp_library_cpp/08_combinatorics_game/nim_sprague_grundy.cpp
;;02_cp_library_cpp/08_combinatorics_game/game_theory_patterns.md
;;02_cp_library_cpp/08_combinatorics_game/burnside_polya.cpp
;;02_cp_library_cpp/08_combinatorics_game/stars_bars_derangements.cpp
;;02_cp_library_cpp/08_combinatorics_game/pigeonhole_inclusion.md
;;02_cp_library_cpp/09_searching_techniques/binary_search_on_answer.cpp
;;02_cp_library_cpp/09_searching_techniques/ternary_search.cpp
;;02_cp_library_cpp/09_searching_techniques/two_pointers.cpp
;;02_cp_library_cpp/09_searching_techniques/meet_in_the_middle.cpp
;;02_cp_library_cpp/09_searching_techniques/coordinate_compression.cpp
;;02_cp_library_cpp/09_searching_techniques/prefix_sum_difference_array.cpp
;;02_cp_library_cpp/09_searching_techniques/2d_prefix_sum.cpp
;;02_cp_library_cpp/09_searching_techniques/parallel_binary_search.cpp
;;02_cp_library_cpp/10_greedy_misc/interval_scheduling.cpp
;;02_cp_library_cpp/10_greedy_misc/huffman_coding.cpp
;;02_cp_library_cpp/10_greedy_misc/fast_io_hacks.cpp
;;02_cp_library_cpp/10_greedy_misc/random_generators_hash_killers.cpp
;;02_cp_library_cpp/10_greedy_misc/bit_manipulation_tricks.cpp
;;02_cp_library_cpp/10_greedy_misc/date_time_utils.cpp
;;02_cp_library_cpp/10_greedy_misc/interactive_problem_template.cpp
;;02_cp_library_cpp/11_advanced/fft_applications.cpp
;;02_cp_library_cpp/11_advanced/simplex_lp.cpp
;;02_cp_library_cpp/11_advanced/bitset_optimizations.cpp
;;02_cp_library_cpp/11_advanced/offline_techniques_cdq.cpp
;;02_cp_library_cpp/11_advanced/randomized_algorithms.cpp
;;02_cp_library_cpp/11_advanced/heuristics_sa_hill_climb.cpp

;;03_interview_prep/patterns/two_pointers.cpp
;;03_interview_prep/patterns/sliding_window.cpp
;;03_interview_prep/patterns/fast_slow_pointers.cpp
;;03_interview_prep/patterns/merge_intervals.cpp
;;03_interview_prep/patterns/cyclic_sort.cpp
;;03_interview_prep/patterns/in_place_linked_list_reversal.cpp
;;03_interview_prep/patterns/tree_bfs_dfs.cpp
;;03_interview_prep/patterns/two_heaps.cpp
;;03_interview_prep/patterns/subsets_backtracking.cpp
;;03_interview_prep/patterns/modified_binary_search.cpp
;;03_interview_prep/patterns/top_k_elements.cpp
;;03_interview_prep/patterns/k_way_merge.cpp
;;03_interview_prep/patterns/topological_sort.cpp
;;03_interview_prep/patterns/monotonic_stack.cpp
;;03_interview_prep/patterns/union_find.cpp
;;03_interview_prep/patterns/trie_patterns.cpp
;;03_interview_prep/by_topic/arrays/
;;03_interview_prep/by_topic/strings/
;;03_interview_prep/by_topic/linked_list/
;;03_interview_prep/by_topic/trees/
;;03_interview_prep/by_topic/graphs/
;;03_interview_prep/by_topic/dp/
;;03_interview_prep/by_topic/heap/
;;03_interview_prep/by_topic/backtracking/
;;03_interview_prep/by_topic/bit_manipulation/
;;03_interview_prep/design_problems/lru_cache.cpp
;;03_interview_prep/design_problems/lfu_cache.cpp
;;03_interview_prep/design_problems/min_stack.cpp
;;03_interview_prep/design_problems/trie_design.cpp
;;03_interview_prep/design_problems/iterator_design.cpp
;;03_interview_prep/design_problems/rate_limiter.cpp
;;03_interview_prep/oop_system_design_lld/parking_lot_elevator_etc.cpp
;;03_interview_prep/cheatsheets/big_o_cheatsheet.md
;;03_interview_prep/cheatsheets/common_mistakes.md
;;03_interview_prep/cheatsheets/interview_checklist.md

;;04_practice/codeforces/div2/
;;04_practice/codeforces/div3/
;;04_practice/codeforces/educational/
;;04_practice/atcoder/
;;04_practice/cses/
;;04_practice/leetcode/
;;04_practice/lightoj_uva_spoj/
;;04_practice/icpc_contests/
;;04_practice/upsolve/

;;05_notes/roadmap.md
;;05_notes/topic_checklist.md
;;05_notes/tricks_and_formulas.md
;;05_notes/complexity_limits.md
;;05_notes/editorials_summaries/

;;06_codebook/selected_snippets/

@@FILE 02_cp_library_cpp/00_setup/template.cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using ull = unsigned long long;
using pii = pair<int, int>;
using pll = pair<ll, ll>;
using vi = vector<int>;
using vll = vector<ll>;

#define all(x) (x).begin(), (x).end()
#define sz(x) ((int)(x).size())
#define pb push_back
#define F first
#define S second

const int MOD = 1e9 + 7;
const int INF = 1e9;
const ll LINF = 1e18;

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
@@END

@@FILE 02_cp_library_cpp/00_setup/template_debug.cpp
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
@@END

@@FILE 02_cp_library_cpp/00_setup/compile_flags.md
# Compile flags (Windows / MinGW g++)

- Normal:  `g++ -std=c++17 -O2 -Wall -o out.exe file.cpp`
- Local debug: `g++ -std=c++17 -O2 -DLOCAL -Wall -Wextra -o out.exe file.cpp`
- Sanitizers (works best on WSL/Linux): `-fsanitize=address,undefined -g`
@@END

@@FILE .gitignore
*.exe
*.o
*.out
out/
.vscode/
input.txt
output.txt
@@END

@@FILE README.md
# DSA + CP Library

Personal library of data structures, competitive programming templates and interview patterns.

| Folder | Contents |
|---|---|
| `01_academic_ds_c` | Academic data structures implemented in C |
| `02_cp_library_cpp` | Contest-ready C++ templates, grouped by topic |
| `03_interview_prep` | Interview patterns, design problems, cheatsheets |
| `04_practice` | Solved problems by platform, plus upsolves |
| `05_notes` | Roadmap, checklist, formulas, complexity limits |
| `06_codebook` | Trimmed snippets for a printable team reference |
| `scripts` | Windows helper scripts (batch) |

## Helper scripts (run from the repo root in cmd)

    scripts\new_problem.bat codeforces\div2 1900A
    scripts\run.bat 04_practice\codeforces\div2\1900A.cpp
    scripts\stress.bat sol.cpp brute.cpp gen.cpp 500

## File header convention

Every template starts with: purpose, time/space complexity, usage example, problem link.
@@END

@@FILE scripts/new_problem.bat
@echo off
rem Usage: scripts\new_problem.bat codeforces\div2 1900A
if "%~2"=="" (
    echo Usage: scripts\new_problem.bat PLATFORM NAME
    echo Example: scripts\new_problem.bat codeforces\div2 1900A
    exit /b 1
)
set "ROOT=%~dp0.."
if not exist "%ROOT%\04_practice\%~1" mkdir "%ROOT%\04_practice\%~1"
if exist "%ROOT%\04_practice\%~1\%~2.cpp" (
    echo Already exists.
    exit /b 1
)
copy "%ROOT%\02_cp_library_cpp\00_setup\template.cpp" "%ROOT%\04_practice\%~1\%~2.cpp" >nul
echo Created 04_practice\%~1\%~2.cpp
@@END

@@FILE scripts/run.bat
@echo off
rem Usage: scripts\run.bat path\to\sol.cpp   (reads input.txt next to the file if present)
if "%~1"=="" (
    echo Usage: scripts\run.bat path\to\sol.cpp
    exit /b 1
)
if not exist "%~dp0..\out" mkdir "%~dp0..\out"
set "EXE=%~dp0..\out\%~n1.exe"
g++ -std=c++17 -O2 -Wall -DLOCAL -o "%EXE%" "%~1"
if errorlevel 1 (
    echo Compilation failed
    exit /b 1
)
if exist "%~dp1input.txt" (
    "%EXE%" < "%~dp1input.txt"
) else (
    "%EXE%"
)
@@END

@@FILE scripts/stress.bat
@echo off
rem Usage: scripts\stress.bat sol.cpp brute.cpp gen.cpp [iterations]
rem gen.exe receives the test number as argv[1] (use it as the random seed).
setlocal
if "%~3"=="" (
    echo Usage: scripts\stress.bat sol.cpp brute.cpp gen.cpp [iterations]
    exit /b 1
)
set "N=%~4"
if "%N%"=="" set "N=500"
set "T=%TEMP%\stress_cp"
if not exist "%T%" mkdir "%T%"
g++ -std=c++17 -O2 -o "%T%\sol.exe" "%~1" || exit /b 1
g++ -std=c++17 -O2 -o "%T%\brute.exe" "%~2" || exit /b 1
g++ -std=c++17 -O2 -o "%T%\gen.exe" "%~3" || exit /b 1
for /l %%i in (1,1,%N%) do (
    "%T%\gen.exe" %%i > "%T%\in.txt"
    "%T%\sol.exe" < "%T%\in.txt" > "%T%\o1.txt"
    "%T%\brute.exe" < "%T%\in.txt" > "%T%\o2.txt"
    fc /b "%T%\o1.txt" "%T%\o2.txt" >nul
    if errorlevel 1 (
        echo MISMATCH on test %%i. Input saved at %T%\in.txt
        exit /b 1
    )
)
echo All %N% tests passed.
@@END

@@FILE 06_codebook/build_pdf.bat
@echo off
rem Builds a printable codebook PDF from 06_codebook\selected_snippets.
rem Needs pandoc + a LaTeX engine (for example MiKTeX). Fill in once you have snippets.
echo TODO: add the pandoc command for your codebook layout
@@END
