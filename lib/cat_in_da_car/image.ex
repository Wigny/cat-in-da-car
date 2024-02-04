defmodule CatInDaCar.Image do
  def server do
    {:ok, resnet} = Bumblebee.load_model({:hf, "microsoft/resnet-50"})
    {:ok, featurizer} = Bumblebee.load_featurizer({:hf, "microsoft/resnet-50"})

    Bumblebee.Vision.image_classification(resnet, featurizer)
  end

  def predict(serving, image) do
    Nx.Serving.run(serving, image)
  end
end
