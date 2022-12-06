class ChainsController < ApplicationController
  before_action :set_bike, only: %i[index show edit update create]
  before_action :set_chain, only: %i[edit update]

    GOOD_STATE = {
      state: "Votre chaîne est en bon état. Nettoyez et graissez-là une fois par mois.",
      broken: "Votre vélo peut rouler, veillez à suivres nos conseils d’entretien et de suivi d’usure pour roulez dans des conditions optimales !",
      rust: "Continuez à bien entretenir votre transmission en suivant nos conseils afin de garder celle-ci en état de marche le plus longtemps possible... pas de changement superflu !",
      derail: ["Remettre sa chaîne en rail est une opération simple et utile à connaître : on vous explique comment faire, suivre le guide !", "Continuez à bien entretenir votre transmission en suivant nos conseils afin de garder celle-ci en état de marche le plus longtemps possible... pas de changement superflu !"]
    }

    MIDDLE_STATE = {
      state: "Effectuez un dégraissage et nettoyage approfondi de votre chaîne et des éléments de dérailleur. Votre chaîne peut encore rouler tant qu’elle est propre et ne présente pas de traces d’usure visibles",
      broken: "Vous devez changer votre chaîne pour pouvoir utiliser votre vélo. Pas d’inquiétude, c’est une opération simple et peu coûteuse !",
      rust: "Utilisez un produit anti-rouille pour remettre la chaîne en état. Si la rouille ne part pas ou qu’elle a causé des dégâts visibles, envisagez un remplacement de la chaîne.",
      chainlink: "Vous avez un maillon cassé : suivez nos conseils pour le changer et remettre votre chaîne en bon état."
    }

    BAD_STATE = {
      state: "Considérez le remplacement de votre chaîne, ou la consultation d’un spécialiste pour vous aider à réparer vos pièces.",
      derail: "Votre transmission ou votre chaîne ont peut-être un problème, nos tutoriels sont là pour vous aider à le résoudre.",
      chainlink: "Vous devez changer votre chaîne. Consultez nos tutoriels ou un spécialiste pour remettre votre vélo en état."
    }

  def index
    @chains = @bike.chains
  end

  def show
    @chain = Chain.find(params[:id])
    # afficher le résultat du diagnostique
    @diag = ChainsDiag.where(chain: @chain)[0]
    @diag_values = @diag.values_at(:state,:broken, :rust, :derail, :chainlink, :note)
    end
  end

  def edit; end

  def create
    @chain = Chain.new(chain_params)
    @chain.bike = @bike

    if @chain.save!
      @chains_diag = create_chains_diag(@chain)
      if @chains_diag.save!
        redirect_to bike_path(@bike)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @chain.update!(chain_params)
    redirect_to bike_path(@bike)
  end

  def destroy
    @chain = Chain.find(params[:id])
    @chain.destroy!
    redirect_to bike_path(@bike), status: :see_other
  end

  private

  def chain_params
    params.require(:chain).permit(:state, :broken, :rust, :derail, :chainlink, photos: [])
  end

  def set_chain
    @chain = Chain.find(params[:id])
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end

  def create_chains_diag(chain)
    diag = ChainsDiag.new(
      chain:,
      state: state_diag(chain),
      broken: broken_diag(chain),
      rust: rust_diag(chain),
      derail: derail_diag(chain),
      chainlink: chainlink_diag(chain)
    )
    diag.note = create_note(diag)
    return diag
  end

  def state_diag(chain)
    case chain.state
    when "bon" || "good"
      return GOOD_STATE[:state]
      # return "Votre chaîne est en bon état. Nettoyez et graissez-là une fois par mois."
    when "moyen" || "medium"
      return MIDDLE_STATE[:state]
      # return "Effectuez un dégraissage et nettoyage approfondi de votre chaîne et des éléments de dérailleur. Votre chaîne peut encore rouler tant qu’elle est propre et ne présente pas de traces d’usure visibles"
    when "mauvais" || "bad"
      return BAD_STATE[:state]
      # return "Considérez le remplacement de votre chaîne, ou la consultation d’un spécialiste pour vous aider à réparer vos pièces."
    when ""
      return nil
    end
  end

  def broken_diag(chain)
    case chain.broken
    when "oui" || "yes"
      return MIDDLE_STATE[:broken]
      # return "Vous devez changer votre chaîne pour pouvoir utiliser votre vélo. Pas d’inquiétude, c’est une opération simple et peu coûteuse !"
    when "non" || "no"
      return GOOD_STATE[:broken]
      # return "Votre vélo peut rouler, veillez à suivres nos conseils d’entretien et de suivi d’usure pour roulez dans des conditions optimales !"
    when "" || nil
      return nil
    end
  end

  def rust_diag(chain)
    case chain.rust
    when "oui" || "yes"
      return MIDDLE_STATE[:rust]
      # return "Utilisez un produit anti-rouille pour remettre la chaîne en état. Si la rouille ne part pas ou qu’elle a causé des dégâts visibles, envisagez un remplacement de la chaîne."
    when "non" || "no"
      return GOOD_STATE[:rust]
      # return "Continuez à bien entretenir votre transmission en suivant nos conseils afin de garder celle-ci en état de marche le plus longtemps possible... pas de changement superflu !"
    when "" || nil
      return nil
    end
  end

  def derail_diag(chain)
    case chain.derail
    when "oui" || "yes" || "oui, je n'arrive pas à la remettre"
      return GOOD_STATE[:derail][0]
      # return "Remettre sa chaîne en rail est une opération simple et utile à connaître : on vous explique comment faire, suivre le guide !"
    when "oui, elle déraille dès que je la remets" || "oui, elle déraille régulièrement"
      return BAD_STATE[:derail]
      # return "Votre transmission ou votre chaîne ont peut-être un problème, nos tutoriels sont là pour vous aider à le résoudre."
    when "non" || "no" || "oui, mais je sais la remettre"
      return GOOD_STATE[:derail][1]
      # return "Continuez à bien entretenir votre transmission en suivant nos conseils afin de garder celle-ci en état de marche le plus longtemps possible... pas de changement superflu !"
    when "" || nil
      return nil
    end
  end

  def chainlink_diag(chain)
    case chain.chainlink
    when "oui" || "yes" || "" || nil
      return nil
    when "non" || "no" || "un maillon semble cassé"
      return MIDDLE_STATE[:chainlink]
      # return "Vous avez un maillon cassé : suivez nos conseils pour le changer et remettre votre chaîne en bon état."
    when "la chaîne n’est plus fermée ou est en plusieurs morceaux"
      return BAD_STATE[:chainlink]
      # return "Vous devez changer votre chaîne. Consultez nos tutoriels ou un spécialiste pour remettre votre vélo en état."
    end
  end

  def create_note(diag)
    # Attribuer une note à l'état du vélo
    note = 1
    iterator = {state: diag.state, broken: diag.broken, rust: diag.rust, derail: diag.derail, chainlink: diag.chainlink}
    iterator.each_pair do |key, value|
      if GOOD_STATE.value? value
        note += 1
      elsif MIDDLE_STATE.value? value
        note -= 0.5
      elsif BAD_STATE.value? value
        note -= 1
      end
    end
    return note
  end
end
