# UnicodeSetOperations.jl

Make your set operations a little more pretty. 

### Installation

Add the package with:

```julia
] add https://github.com/April-Hannah-Lena/UnicodeSetOperations.jl.git
```

### Functionalities

- The empty set `ø` is available in unicode as a generic empty set which adapts to types depending on operations
- Set difference is defined as a unicode infix operator `⧷`. We use this instead of the (maybe expected) `\` or `-` since this would be type piracy and could cause unexpected results if users are not aware that the package is in use. 
- Symmetric difference is defined as a unicode infix operator `⊖`. 
- In-place operations are defined as unicode infix operators `∪ꜝ, ∩ꜝ, ⧷ꜝ, ⊖ꜝ`. These are just aliases for `union!, intersect!, setdiff!, symdiff!`, respectively. 

### Usage

```julia
julia> using UnicodeSetOperations

julia> ∅    # \emptyset <TAB>
∅ (Empty Set)

julia> S = Set([1, 2, 3, 4, 4])
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> S == ∅
false

julia> S != ∅
true

julia> S ∪ ∅
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> S ∩ ∅
Set{Int64}()

julia> S ⧷ ∅    # \rsolbar <TAB>
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> ∅ ⧷ S    # \rsolbar <TAB>
Set{Int64}()

julia> S ⧷ S
Set{Int64}()

julia> ∅ ⊆ S
true

julia> S ⊈ ∅
true

julia> isdisjoint(S, ∅)
true

julia> while S ≠ ∅
           pop!(S)
       end

julia> S
Set{Int64}()

julia> S == ∅
true

julia> S = Set([1, 2, 3, 4, 4])
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> S ∩ꜝ ∅   # \cap <TAB> \^! <TAB>
Set{Int64}()

julia> S
Set{Int64}()
```

### Using your own Types

If you want UnicodeSetOperations to work with your defined type,
ensure that your type has the methods `empty!`, `copy`, `iterate`.
Optionally, you can define `isempty` as well to make the code run 
faster.
