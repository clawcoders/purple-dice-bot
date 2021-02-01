defmodule Dice.Lists do
  def quotes do
    [
      "Mas o que esse deus tem com cozinha francesa?\n    -Kaulo Pogos",
      "FALTOU UM!!!\n   -Bambi",
      "I'll step on your face!\n    -Luna Shiry"
    ]
  end

  def classes(plural \\ false) do
    [
      "abençoado",
      "bárbaro",
      "bardo",
      "clérigo",
      "druida",
      "feiticeiro",
      "guerreiro",
      "ladino",
      "mago",
      "monge",
      "nobre",
      "paladino",
      "ranger",
      "samurai",
      "swashbuckler"
    ]
    |> turn_plural(plural)
  end

  def races(plural \\ false) do
    [
      "anão",
      "elfo",
      "goblin",
      "halfling",
      "meio-elfo",
      "meio-orc",
      "minauro",
      "minotauro",
      "moreau",
      "qareen",
      "humano"
    ]
    |> turn_plural(plural)
  end

  def gods do
    [
      "Allihanna",
      "Azgher",
      "Hynnin",
      "Kallyadranoch",
      "Keenn",
      "Khalmyr",
      "Lena",
      "Lin-Wu",
      "Marah",
      "Megalokk",
      "Nimb",
      "Oceano",
      "Ragnar",
      "Sszzaas",
      "Tanna-Toh",
      "Tauron",
      "Tenebra",
      "Thyatis",
      "Wynna",
      "Valkaria"
    ]
  end

  def lore do
    [
      "teve os pais assassinados",
      "enlouqueceu",
      "treinou durante #{Enum.random(2..20)} anos",
      "foi amaldiçoado por #{Enum.random(gods())}",
      "foi quase morto por um #{Enum.random(classes())}",
      "foi caçado por #{Enum.random(classes(true))}",
      "fugiu de casa",
      "ficou entediado",
      "teve sua vila completamente destruída",
      "foi escravizado por um #{Enum.random(races())}",
      "foi levado de návio á outro reino"
    ]
  end

  def objective do
    [
      "procura ter sua vingança",
      "que quer ficar rico",
      "deseja destruir #{Enum.random(gods())}",
      "deseja acabar com todos os #{Enum.random(classes(true))}",
      "deseja se aventurar pelo mundo",
      "deseja se tornar famoso por todo o reinado",
      "que sonha se tornar um herói",
      "deseja fazer o bem para os outros"
    ]
  end

  defp turn_plural(list, plural) do
    case plural do
      true ->
        Enum.map(list, fn x ->
          cond do
            x == "abençoado" -> "abençoados de #{Enum.random(gods())}"
            x == "clérigo" -> "clérigos de #{Enum.random(gods())}"
            x == "moreau" -> "moreais"
            x == "anão" -> "anões"
            true -> x <> "s"
          end
        end)

      false ->
        Enum.map(list, fn x ->
          cond do
            x == "abençoado" -> "abençoado de #{Enum.random(gods())}"
            x == "clérigo" -> "clérigo de #{Enum.random(gods())}"
            true -> x
          end
        end)
    end
  end
end
