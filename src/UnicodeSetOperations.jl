module UnicodeSetOperations

export ⊖, ∅

Base.:(\)(s1::AbstractSet, s2) = setdiff(s1, s2)
Base.:(\)(::EmptySet, s) = ∅
⊖(s1, s2) = symdiff(s1, s2)

struct EmptySet #= <: AbstractSet{Any} =# end
const ∅ = EmptySet()

# compatibility function to avoid REPL breaking
_isempty(s) = isempty(s)
for type in (Function, Core.Module, Core.LineNumberNode)
    @eval _isempty(::$type) = false
end

Base.length(::EmptySet) = 0
Base.iterate(::EmptySet, i...) = nothing
Base.isempty(::EmptySet) = true
Base.show(io::IO, ::EmptySet) = print(io, "∅")

for (func, types, (firstexpr, lastexpr)) in (
        (:(==),           (Any, AbstractSet, AbstractArray, Core.WeakRef, Missing),     (:(_isempty(s)), :(_isempty(s)))),
        (:issubset,       (Any,),                                                       (:(_isempty(s)), :true)),
        (:isdisjoint,     (Any,),                                                       (:true, :true)),
        (:issetequal,     (Any, AbstractSet),                                           (:(_iempty(s)), :(_isempty(s)))),
        (:union!,         (Any, AbstractArray, BitSet, AbstractSet),                    (:s, :s)),
        (:union,          (Any, BitSet, AbstractSet),                                   (:(copy(s)), :(copy(s)))),
        (:intersect!,     (Any, AbstractArray, AbstractSet, BitSet),                    (:(empty!(s)), :(empty!(copy(s))))),
        (:intersect,      (Any, AbstractRange, AbstractSet),                            (:(empty!(copy(s))), :(empty!(copy(s))))),
        (:setdiff!,       (Any, AbstractArray, AbstractSet),                            (:s, :∅)),
        (:setdiff,        (Any, AbstractSet),                                           (:(copy(s)), :(empty!(copy(s))))),
        (:symdiff!,       (Any, AbstractArray, BitSet, AbstractSet),                    (:s, :s)),
        (:symdiff,        (Any,),                                                       (:(copy(s)), :(copy(s))))
    )

    for type in types
        @eval Base.$func(s::$type, ::EmptySet) = $firstexpr
        @eval Base.$func(::EmptySet, s::$type) = $lastexpr
    end

end

for func in (:issetequal, :isdisjoint)
    @eval Base.$func(::EmptySet, ::EmptySet) = true
end

for func in (:(==), :issubset)
    @eval Base.$func(::EmptySet, ::EmptySet) = false
end

for func in (:union!, :union, :intersect!, :intersect, :setdiff!, :setdiff, :symdiff!, :symdiff)
    @eval Base.$func(::EmptySet, ::EmptySet) = ∅
end

end # module
