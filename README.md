# UnicodeSetOperations.jl

Make your set operations a little more pretty

Add the package with:

```julia
] add https://github.com/April-Hannah-Lena/UnicodeSetOperations.jl.git
```

### Usage

```julia
julia> using UnicodeSetOperations

julia> ∅
∅

julia> S = Set([1,2,3,4])
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> S == ∅
false

julia> S ∪ ∅
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> S ∩ ∅
Set{Int64}()

julia> S ⊖ ∅    # ⊖ == symdiff
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> ∅ ⊆ S
true

julia> S ⊆ ∅
false

julia> S \ ∅    # \ == setdiff   (only when first argument isa AbstractSet)
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> ∅ \ S
Set{Int64}()

julia> isdisjoint(S, ∅)
true

julia> while S ≠ ∅
           pop!(S)
       end

julia> S
Set{Int64}()

julia> S == ∅
true

```

### Using your own Types

If you want UnicodeSetOperations to work with your defined type,
ensure that your type has the methods `empty!`, `copy`, `iterate`.
Optionally, you can define `isempty` as well to make the code run 
faster.
