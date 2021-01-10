abstract type GpFunction end

abstract type GpFunction1p <: GpFunction end
abstract type GpFunction2p <: GpFunction end
abstract type GpFunction3p <: GpFunction end
abstract type GpFunction4p <: GpFunction end


abstract type NegateFunction <: GpFunction1p end
abstract type ExpFunction <: GpFunction1p end

abstract type PlusFunction <: GpFunction2p end
abstract type MinusFunction <: GpFunction2p end
abstract type ProductFunction <: GpFunction2p end
abstract type DivideFunction <: GpFunction2p end
abstract type PowerFunction <: GpFunction2p end


