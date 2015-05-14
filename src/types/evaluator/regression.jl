load("simple", dirname(@__FILE__))
load("../fitness/simple", dirname(@__FILE__))

type RegressionEvaluator <: SimpleEvaluator
  num_samples::Int
  samples::Vector{Vector{Float}}

  RegressionEvaluator(samples::Vector{Vector{Float}}) =
    new(length(samples), samples)
end

function evaluate!(e::RegressionEvaluator, s::State, c::Individual)
  sse = zero(Float)
  diff = zero(Float)
  for x in e.samples
    diff = x[2] - execute(get(c.tree), x[1])
    sse += diff * diff
  end
  SimpleFitness{Float}(false, sse)
end

register(joinpath(dirname(@__FILE__), "regression.manifest.yml"))
