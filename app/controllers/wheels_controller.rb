class WheelsController < ApplicationController
  before_action :set_bike, only: %i[index show edit update create]
  before_action :set_wheel, only: %i[edit update]

  GOOD_STATE = {
    puncture: [
      "Tout roule, on dirait ! Saviez-vous que la pression recommandée pour le gonflage est généralement écrite sur le flan du pneu? Veillez à bien respecter celle-ci : un pneu sous ou sur-gonflé présente un risque accru de crevaison !", "Et si on révisait ensemble les bases du gonflage? Rien de mieux pour rouler en toute sécurité !"
    ],
    bent: "Tout va bien ! Des micros voilages peuvent apparaître avec le temps : les roues sont fortement sollicitées en roulant. Les voilages légers peuvent être corrigés grâce à une clef à rayon, ou directement via un professionnel.",
    spoke: "Votre roue est prête pour affronter la route et les pavés (si elle tourne droite, bien entendu!).",
    noise: "Quoi de plus doux et mélodieux que le son d’une roue libre?",
    tyre: "Tout va bien ! On continue comme ça et on s'occupe des autres problèmes."
  }

  MIDDLE_STATE = {
    puncture: "Rien de plus normal... les pneus, ça se dégonfle... on vous explique comment bien regonfler vos pneus.",
    noise: "Les bruits de roulement sont sans gravité la plupart du temps, mais mieux vaut en connaître la provenance pour éviter tout désagrément. On vous aide à en comprendre l’origine?",
    tyre: "La plupart des coupures et trous visibles sur un pneu est sans gravité. Si vous constatez des lésions ou déchirures plus larges que la largeur d’un doigt, il peut être nécessaire de remplacer le pneu."
  }

  BAD_STATE = {
    puncture: "La pression baisse rapidement ou de l’air s’échappe? Regardons ensemble d’où vient le problème, et comment le régler facilement.",
    bent: "Votre roue est voilée, ne roulez pas avec le vélo. Deux solutions s’offrent à vous : faire dévoiler la roue par un professionnel, ou bien la remplacer si la torsion est trop importante.",
    spoke: "Les casses de rayon peuvent être dangereuses s’il y en a plusieurs sur une même roue. Dans ce cas, il est conseillé de faire changer votre jante auprès d’un réparateur proche de chez vous.",
    noise: "Des frottements ou un blocage? Les patins de frein frottent sûrement sur vos jantes. Vous risquez de vous fatiguer rapidement en pédalant, réglons ça ensemble avec quelques régalges simples !",
    tyre: "Vous allez devoir remettre votre pneu dans le rail de la jante. C’est simple et rapdie, mais il faut avoir le coup de main. On vous explique tout pas à pas."
  }

  def index
    @wheels = @bike.wheels
  end

  def show
    @wheel = Wheel.find(params[:id])
  end

  def edit; end

  def create
    @wheel = Wheel.new(wheel_params)
    @wheel.bike = @bike
    if @wheel.save!
      @wheels_diag = create_wheels_diag(@wheel)
      create_wheels_diag(@wheel)
      if @wheels_diag.save!
        flash[:notice] = "Votre bilan a bien été sauvegardé."
        redirect_to bike_path(@bike)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
    # on récupère la note de wheel pour créer la note globale du vélo
    @note = @wheels_diag.note
  end

  def update
    @wheel.update!(wheel_params)
    flash[:notice] = "Votre bilan a bien été sauvegardé."
    redirect_to bike_path(@bike)
  end

  def destroy
    @wheel = Wheel.find(params[:id])
    @wheel.destroy!
    redirect_to bike_path(@bike), status: :see_other
  end

  private

  def wheel_params
    params.require(:wheel).permit(:puncture, :bent, :spoke, :noise, :tyre, photos: [])
  end

  def set_wheel
    @wheel = Wheel.find(params[:id])
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end

  def create_wheels_diag(wheel)
    diag = WheelsDiag.new(
      wheel:,
      puncture: puncture_diag(wheel),
      bent: bent_diag(wheel),
      spoke: spoke_diag(wheel),
      noise: noise_diag(wheel),
      tyre: tyre_diag(wheel)
    )
    diag.note = create_note(diag)
    return diag
  end

  def puncture_diag(wheel)
    case wheel.puncture
    when "true" || "oui"
      return GOOD_STATE[:puncture][0]
    when "false" || "non"
      return MIDDLE_STATE[:puncture]
    when "je ne sais pas"
      return GOOD_STATE[:puncture][1]
    when "mon pneu se dégonfle et/ou je pense qu’il y a une crevaison"
      return BAD_STATE[:puncture]
    end
  end

  def bent_diag(wheel)
    case wheel.bent
    when "true" || "oui"
      return BAD_STATE[:bent]
    when "false" || "non"
      return GOOD_STATE[:bent]
    end
  end

  def spoke_diag(wheel)
    case wheel.spoke
    when "true" || "oui"
      return BAD_STATE[:bent]
    when "false" || "non"
      return GOOD_STATE[:spoke]
    end
  end

  def noise_diag(wheel)
    case wheel.noise
    when "false" || "non"
      return GOOD_STATE[:noise]
    when "j’entends un grincement ou un cliquetis"
      return MIDDLE_STATE[:noise]
    when "la roue tourne mal" || "j’entends un frottement"
      return BAD_STATE[:noise]
    end
  end

  def tyre_diag(wheel)
    case wheel.tyre
    when "les pneus sont dans les jantes et en état correct"
      return GOOD_STATE[:tyre]
    when "j’observe des coupures, déchirures ou trous dans les pneus"
      return MIDDLE_STATE[:tyre]
    when "un ou plusieurs pneus ne tient pas dans la jante"
      return BAD_STATE[:tyre]
    end
  end

  def create_note(diag)
    # Attribuer une note à l'état du vélo
    note = 5
    iterator = { puncture: diag.puncture, bent: diag.bent, spoke: diag.spoke, noise: diag.noise, tyre: diag.tyre }
    iterator.each_pair do |_key, value|
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
