using UnicodeSetOperations
using Test
using OrderedCollections

@testset begin

    set = Set{Int}()

    @test set == ∅
    @test ∅ == set

    objects = [1, 2, 3, 4, 4]

    for set in (objects, Set(objects), BitSet(objects))

        @test length(∅) == 0
        @test isempty(∅) == true

        @test set != ∅
        @test ∅ != set

        @test set ⊈ ∅
        @test ∅ ⊆ set

        @test isdisjoint(∅, set) == true
        @test isdisjoint(set, ∅) == true

        @test set ∪ ∅ == set
        @test set ∪ꜝ ∅ === set

        @test set ∩ ∅ == empty!(copy(set))
        @test ∅ ∩ set == empty!(copy(set))

        @test set ⧷ ∅ == set
        @test ∅ ⧷ set == ∅

        @test set Δ ∅ == set
        @test ∅ Δ set == set

    end
    
end
