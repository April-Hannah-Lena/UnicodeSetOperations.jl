module UnicodeSetOperations

export ⊖, ∅

struct EmptySet <: AbstractSet{Any} end
const ∅ = EmptySet()

Base.:(\)(s1::AbstractSet, s2) = setdiff(s1, s2)
⊖(s1, s2) = symdiff(s1, s2)

# compatibility function to avoid REPL breaking
_isempty(s) = isempty(s)
for type in (Function, Core.Module, Core.LineNumberNode)
    @eval _isempty(::$type) = false
end

Base.length(::EmptySet) = 0
Base.iterate(::EmptySet, i...) = nothing
Base.isempty(::EmptySet) = true
Base.show(io::IO, ::EmptySet) = print(io, "∅")
Base.show(io::IO, ::MIME"text/plain", ::EmptySet) = show(io, ∅)

for (func, types, firstexpr, lastexpr, bothexpr) in (
        (:(==),           (Any, AbstractSet, AbstractArray, Core.WeakRef, Missing),     :(_isempty(s)),         :(_isempty(s)),      :false ),
        (:issubset,       (Any,),                                                       :(_isempty(s)),         :true,               :false ),
        (:isdisjoint,     (Any,),                                                       :true,                  :true,               :true  ),
        (:issetequal,     (Any, AbstractSet),                                           :(_iempty(s)),          :(_isempty(s)),      :true  ),
        (:union!,         (Any, AbstractArray, BitSet, AbstractSet),                    :s,                     :s,                  :∅     ),
        (:union,          (Any, BitSet, AbstractSet),                                   :(copy(s)),             :(copy(s)),          :∅     ),
        (:intersect!,     (Any, AbstractArray, AbstractSet, BitSet),                    :(empty!(s)),           :(empty!(copy(s))),  :∅     ),
        (:intersect,      (Any, AbstractRange, AbstractSet),                            :(empty!(copy(s))),     :(empty!(copy(s))),  :∅     ),
        (:setdiff!,       (Any, AbstractArray, AbstractSet),                            :s,                     :(empty!(copy(s))),  :∅     ),
        (:setdiff,        (Any, AbstractSet),                                           :(copy(s)),             :(empty!(copy(s))),  :∅     ),
        (:symdiff!,       (Any, AbstractArray, BitSet, AbstractSet),                    :s,                     :s,                  :∅     ),
        (:symdiff,        (Any,),                                                       :(copy(s)),             :(copy(s)),          :∅     )
    )

    for type in types
        @eval Base.$func(s::$type, ::EmptySet)   = $firstexpr
        @eval Base.$func(::EmptySet, s::$type)   = $lastexpr
    end
    
    @eval Base.$func(::EmptySet, ::EmptySet) = $bothexpr
    
end

end # module
