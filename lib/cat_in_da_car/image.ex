defmodule CatInDaCar.Image do
  def server do
    {:ok, resnet} = Bumblebee.load_model({:hf, "microsoft/resnet-50"})
    {:ok, featurizer} = Bumblebee.load_featurizer({:hf, "microsoft/resnet-50"})

    Bumblebee.Vision.image_classification(resnet, featurizer)
  end

  def predict(image) do
    Nx.Serving.run(:image_classification, image)
  end
end
