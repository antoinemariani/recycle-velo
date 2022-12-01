class ChainsController < ApplicationController
  before_action :set_bike, only: %i[index show create]

  def index
    @chains = @bike.chains
  end

  def show
    @chain = Chain.find(params[:id])
  end

  def create
    @chain = Chain.new(chain_params)
    @chain.bike = @bike
    if @chain.save!
      create_chains_diag(@chain)
      if @chains_diag.save!
        redirect_to bike_path(@bike)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @chain = Chain.find(params[:id])
  end

  def update
    @chain = Chain.find(params[:id])
    @chain.user = current_user
    @chain.bike = @bike
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
    params.require(:chain).permit(:state, :broken, :rust, :derail, :chainlink)
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end

  def create_chains_diag(chain)
    @chains_diag = ChainsDiag.new(
      chain:,
      state: state_diag(chain),
      broken: broken_diag(chain),
      rust: rust_diag(chain),
      derail: derail_diag(chain),
      chainlink: chainlink_diag(chain)
    )
  end

  def state_diag(chain)
    case chain.state
    when "bon" || "good"
      return "Votre chaîne est en bon état. Nettoyez et graissez-là une fois par mois."
    when "moyen" || "medium"
      return "Effectuez un dégraissage et nettoyage approfondi de votre chaîne et des éléments de dérailleur.  Votre chaîne peut encore rouler tant qu’elle est propre et ne présente pas de traces d’usure visibles"
    when "mauvais" || "bad"
      return "Considérez le remplacement de votre chaîne, ou la consultation d’un spécialiste pour vous aider à réparer vos pièces."
    when ""
      return nil
    end
  end

  def broken_diag(chain)
    case chain.broken
    when true || "oui" || "yes"
      return "Vous devez changer votre chaîne pour pouvoir utiliser votre vélo. Pas d’inquiétude, c’est une opération simple et peu coûteuse !"
    when false || "non" || "no"
      return "Votre vélo peut rouler, veillez à suivres nos conseils d’entretien et de suivi d’usure pour roulez dans des conditions optimales !"
    when "" || nil
      return nil
    end
  end

  def rust_diag(chain)
    case chain.rust
    when true || "oui" || "yes"
      return "Utilisez un produit anti-rouille pour remettre la chaîne en état. Si la rouille ne part pas ou qu’elle a causé des dégâts visibles, envisagez un remplacement de la chaîne."
    when false || "non" || "no"
      return "Continuez à bien entretenir votre transmission en suivant nos conseils afin de garder celle-ci en état de marche le plus longtemps possible... pas de changement superflu !"
    when "" || nil
      return nil
    end
  end

  def derail_diag(chain)
    case chain.derail
    when "oui" || "yes" || "oui, je n'arrive pas à la remettre"
      return "Remettre sa chaîne en rail est une opération simple et utile à connaître : on vous explique comment faire, suivre le guide !"
    when "oui, elle déraille dès que je la remets" || "oui, elle déraille régulièrement"
      return "Votre transmission ou votre chaîne ont peut-être un problème, nos tutoriels sont là pour vous aider à le résoudre."
    when "non" || "no" || "oui, mais je sais la remettre"
      return "Continuez à bien entretenir votre transmission en suivant nos conseils afin de garder celle-ci en état de marche le plus longtemps possible... pas de changement superflu !"
    when "" || nil
      return nil
    end
  end

  def chainlink_diag(chain)
    case chain.chainlink
    when "oui" || "yes" || true || "" || nil
      return nil
    when "non" || "no" || "un maillon semble cassé"
      return "Vous avez un maillon cassé : suivez nos conseils pour le changer et remettre votre chaîne en bon état."
    when "la chaîne n’est plus fermée ou est en plusieurs morceaux"
      return "Vous devez changer votre chaîne. Consultez nos tutoriels ou un spécialiste pour remettre votre vélo en état."
    end
  end
end
