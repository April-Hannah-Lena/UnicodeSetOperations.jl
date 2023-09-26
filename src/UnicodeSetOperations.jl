module UnicodeSetOperations

export ∅
export ∪ꜝ, ∩ꜝ, ⧷, ⧷ꜝ, ⊖, ⊖ꜝ

struct EmptySet <: AbstractSet{Any} end
const ∅ = EmptySet()

const ⧷ = setdiff   # \rsolbar <TAB>
const ⊖ = symdiff   # \Delta <TAB>

const ∪ꜝ = union!   # \cup <TAB> \^! <TAB>
const ∩ꜝ = intersect!
const ⧷ꜝ = setdiff!
const ⊖ꜝ = symdiff!

# compatibility function to avoid REPL breaking
_isempty(s) = isempty(s)
for type in (Function, Core.Module, Core.LineNumberNode)
    @eval _isempty(::$type) = false
end

Base.show(io::IO, ::EmptySet) = print(io, "∅")
Base.show(io::IO, ::MIME"text/plain", ::EmptySet) = print(io, "∅ (Empty Set)")

Base.length(::EmptySet) = 0
Base.iterate(::EmptySet, i...) = nothing
Base.isempty(::EmptySet) = true

Base.:(==)(::EmptySet, ::EmptySet) = true
Base.issubset(::EmptySet, ::EmptySet) = true
Base.isdisjoint(::EmptySet, ::EmptySet) = true
Base.issetequal(::EmptySet, ::EmptySet) = true
Base.union(::EmptySet, ::EmptySet) = ∅
Base.union!(::EmptySet, ::EmptySet) = ∅
Base.intersect(::EmptySet, ::EmptySet) = ∅
Base.intersect!(::EmptySet, ::EmptySet) = ∅
Base.setdiff(::EmptySet, ::EmptySet) = ∅
Base.setdiff!(::EmptySet, ::EmptySet) = ∅
Base.symdiff(::EmptySet, ::EmptySet) = ∅
Base.symdiff!(::EmptySet, ::EmptySet) = ∅

# we need to define for all these types to avoid method ambiguities
for type in (Any, BitSet, Core.WeakRef, Missing)
    @eval begin

        Base.:(==)(set::$type, ::EmptySet)   = _isempty(set)
        Base.:(==)(::EmptySet, set::$type)   = _isempty(set)

        Base.issubset(set::$type, ::EmptySet) = _isempty(set)
        Base.issubset(::EmptySet, set::$type) = true

        Base.isdisjoint(set::$type, ::EmptySet) = true
        Base.isdisjoint(::EmptySet, set::$type) = true

        Base.issetequal(set::$type, ::EmptySet) = _isempty(set)
        Base.issetequal(::EmptySet, set::$type) = _isempty(set)

        Base.union!(set::$type, ::EmptySet) = set
        Base.union!(::EmptySet, set::$type) = copy(set)

        Base.union(set::$type, ::EmptySet) = copy(set)
        Base.union(::EmptySet, set::$type) = copy(set)

        Base.intersect!(set::$type, ::EmptySet) = empty!(set)
        Base.intersect!(::EmptySet, set::$type) = empty!(copy(set))

        Base.intersect(set::$type, ::EmptySet) = empty!(copy(set))
        Base.intersect(::EmptySet, set::$type) = empty!(copy(set))

        Base.setdiff!(set::$type, ::EmptySet) = set
        Base.setdiff!(::EmptySet, set::$type) = empty!(copy(set))

        Base.setdiff(set::$type, ::EmptySet) = copy(set)
        Base.setdiff(::EmptySet, set::$type) = empty!(copy(set))

        Base.symdiff!(set::$type, ::EmptySet) = set
        Base.symdiff!(::EmptySet, set::$type) = set
        
        Base.symdiff(set::$type, ::EmptySet) = copy(set)
        Base.symdiff(::EmptySet, set::$type) = copy(set)
    
    end
end

for type in (AbstractSet, AbstractArray, AbstractVector, AbstractMatrix, Base.OrdinalRange)
    @eval begin

        Base.:(==)(set::$type{T}, ::EmptySet) where T = _isempty(set)
        Base.:(==)(::EmptySet, set::$type{T}) where T = _isempty(set)

        Base.issubset(set::$type{T}, ::EmptySet) where T = _isempty(set)
        Base.issubset(::EmptySet, set::$type{T}) where T = true

        Base.isdisjoint(set::$type{T}, ::EmptySet) where T = true
        Base.isdisjoint(::EmptySet, set::$type{T}) where T = true

        Base.issetequal(set::$type{T}, ::EmptySet) where T = _isempty(set)
        Base.issetequal(::EmptySet, set::$type{T}) where T = _isempty(set)

        Base.union!(set::$type{T}, ::EmptySet) where T = set
        Base.union!(::EmptySet, set::$type{T}) where T = copy(set)

        Base.union(set::$type{T}, ::EmptySet) where T = copy(set)
        Base.union(::EmptySet, set::$type{T}) where T = copy(set)

        Base.intersect!(set::$type{T}, ::EmptySet) where T = empty!(set)
        Base.intersect!(::EmptySet, set::$type{T}) where T = empty!(copy(set))

        Base.intersect(set::$type{T}, ::EmptySet) where T = empty!(copy(set))
        Base.intersect(::EmptySet, set::$type{T}) where T = empty!(copy(set))

        Base.setdiff!(set::$type{T}, ::EmptySet) where T = set
        Base.setdiff!(::EmptySet, set::$type{T}) where T = empty!(copy(set))

        Base.setdiff(set::$type{T}, ::EmptySet) where T = copy(set)
        Base.setdiff(::EmptySet, set::$type{T}) where T = empty!(copy(set))

        Base.symdiff!(set::$type{T}, ::EmptySet) where T = set
        Base.symdiff!(::EmptySet, set::$type{T}) where T = set
        
        Base.symdiff(set::$type{T}, ::EmptySet) where T = copy(set)
        Base.symdiff(::EmptySet, set::$type{T}) where T = copy(set)
    
    end
end

end # module
