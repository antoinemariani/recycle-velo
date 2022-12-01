class WheelsController < ApplicationController
  before_action :set_bike, only: %i[index show create]

  def index
    @wheels = @bike.wheels
  end

  def show
    @wheel = Wheel.find(params[:id])
  end

  def create
    @wheel = Wheel.new(wheel_params)
    @wheel.bike = @bike
    if @wheel.save!
      create_wheels_diag(@wheel)
      if @wheels_diag.save!
        redirect_to bike_path(@bike)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @wheel = Wheel.find(params[:id])
  end

  def update
    @wheel = Wheel.find(params[:id])
    @wheel.user = current_user
    @wheel.bike = @bike
    @wheel.update!(wheel_params)
    redirect_to bike_path(@bike)
  end

  def destroy
    @wheel = Wheel.find(params[:id])
    @wheel.destroy!
    redirect_to bike_path(@bike), status: :see_other
  end

  private

  def wheel_params
    params.require(:wheel).permit(:puncture, :bent, :spoke, :noise, :tyre)
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end

  def create_wheels_diag(wheel)
    @wheels_diag = WheelsDiag.new(
      wheel:,
      puncture: puncture_diag(wheel),
      bent: bent_diag(wheel),
      spoke: spoke_diag(wheel),
      noise: noise_diag(wheel),
      tyre: tyre_diag(wheel)
    )
  end

  def puncture_diag(wheel)
    case wheel.puncture
    when "true" || true || "oui"
      return "Tout roule, on dirait ! Saviez-vous que la pression recommandée pour le gonflage est généralement écrite sur le flan du pneu? Veillez à bien respecter celle-ci : un pneu sous ou sur-gonflé présente un risque accru de crevaison !"
    when "false" || false || "non"
      return "Rien de plus normal... les pneus, ça se dégonfle... on vous explique comment bien regonfler vos pneus."
    when "je ne sais pas"
      return "Et si on révisait ensemble les bases du gonflage? Rien de mieux pour rouler en toute sécurité !"
    when "mon pneu se dégonfle et/ou je pense qu’il y a une crevaison"
      return "La pression baisse rapidement ou de l’air s’échappe? Regardons ensemble d’où vient le problème, et comment le régler facilement."
    end
  end

  def bent_diag(wheel)
    case wheel.bent
    when "true" || true || "oui"
      return "Votre roue est voilée, ne roulez pas avec le vélo. Deux solutions s’offrent à vous : faire dévoiler la roue par un professionnel, ou bien la remplacer si la torsion est trop importante."
    when "false" || false || "non"
      return "Tout va bien ! Des micros voilages peuvent apparaître avec le temps : les roues sont fortement sollicitées en roulant. Les voilages légers peuvent être corrigés grâce à une clef à rayon, ou directement via un professionnel."
    end
  end

  def spoke_diag(wheel)
    case wheel.spoke
    when "true" || true || "oui"
      return "Les casses de rayon peuvent être dangereuses s’il y en a plusieurs sur une même roue. Dans ce cas, il est conseillé de faire changer votre jante auprès d’un réparateur proche de chez vous."
    when "false" || false || "non"
      return "Votre roue est prête pour affronter la route et les pavés (si elle tourne droite, bien entendu!)."
    end
  end

  def noise_diag(wheel)
    case wheel.noise
    when "false" || false || "non"
      return "Quoi de plus doux et mélodieux que le son d’une roue libre?"
    when "j’entends un grincement ou un cliquetis"
      return "Les bruits de roulement sont sans gravité la plupart du temps, mais mieux vaut en connaître la provenance pour éviter tout désagrément. On vous aide à en comprendre l’origine?"
    when "la roue tourne mal" || "j’entends un frottement"
      return "Des frottements ou un blocage? Les patins de frein frottent sûrement sur vos jantes. Vous risquez de vous fatiguer rapidement en pédalant, réglons ça ensemble avec quelques régalges simples !"
    end
  end

  def tyre_diag(wheel)
    case wheel.tyre
    when "les pneus sont dans les jantes et en état correct"
      return "Tout va bien ! On continue comme ça et on s'occupe des autres problèmes."
    when "j’observe des coupures, déchirures ou trous dans les pneus"
      return "La plupart des coupures et trous visibles sur un pneu est sans gravité. Si vous constatez des lésions ou déchirures plus larges que la largeur d’un doigt, il peut être nécessaire de remplacer le pneu."
    when "un ou plusieurs pneus ne tient pas dans la jante"
      return "Vous allez devoir remettre votre pneu dans le rail de la jante. C’est simple et rapdie, mais il faut avoir le coup de main. On vous explique tout pas à pas."
    end
  end
end
