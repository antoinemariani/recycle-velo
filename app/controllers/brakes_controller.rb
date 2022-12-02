class BrakesController < ApplicationController
  before_action :set_bike, only: %i[index show edit update create]
  before_action :set_brake, only: %i[edit update]

  def index
    @brakes = @bike.brakes
  end

  def show
    @brake = Brake.find(params[:id])
  end

  def edit; end

  def create
    @brake = Brake.new(brake_params)
    @brake.bike = @bike
    if @brake.save!
      create_brakes_diag(@brake)
      if @brakes_diag.save!
        redirect_to bike_path(@bike)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @brake.update!(brake_params)
    redirect_to bike_path(@bike)
  end

  def destroy
    @brake = Brake.find(params[:id])
    @brake.destroy!
    redirect_to bike_path(@bike), status: :see_other
  end

  private

  def brake_params
    params.require(:brake).permit(:braking, :handle, :pad, :wire, :squeak)
  end

  def set_brake
    @brake = Brake.find(params[:id])
  end

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end

  def create_brakes_diag(brake)
    @brakes_diag = BrakesDiag.new(
      brake:,
      braking: braking_diag(brake),
      handle: handle_diag(brake),
      pad: pad_diag(brake),
      wire: wire_diag(brake),
      squeak: squeak_diag(brake)
    )
  end

  def braking_diag(brake)
    case brake.braking
    when "true" || true || "oui" || "il freine bien"
      return ""
    when "false" || false || "non" || "il freine mal"
      return "Un simple réglage de la tension des câbles de freinage et des plaquette devrait suffire, suivez le guide !"
    when "il ne freine pas du tout"
      return "Il va vous falloir résoudre les différents problèmes listés ci-dessous pour que votre vélo fonctionne à nouveau"
    end
  end

  def handle_diag(brake)
    case brake.handle
    when "true" || true || "oui"
      return "Bonne nouvelle ! Regardons comment les régler pour que leur souplesse soit optimale et que vous ne vous fassiez pas de crampes en roulant !"
    when "false" || false || "non"
      return nil
    end
  end

  def pad_diag(brake)
    case brake.pad
    when "true" || true || "oui"
      return nil
    when "false" || false || "non"
      return "Il va vous falloir impérativement monter des plaquettes sur votre vélo pour pouvoir rouler, suivez notre guide sur le sujet pour en savoir plus."
    end
  end

  def wire_diag(brake)
    case brake.wire
    when "true" || true || "oui"
      return nil
    when "false" || false || "non"
      return "Faisons le point ensemble sur vos câbles de frein pour les réparer ou les remplacer."
    when "je ne sais pas"
      return "Regardons ensemble où se trouvent les câbles de freinage et s’ils fonctionnent bien."
    end
  end

  def squeak_diag(brake)
    case brake.squeak
    when "true" || true || "oui"
      return "On a tous déjà roulé avec des freins qui grincent ! Un petit réglage en suivant notre tuto et le tour sera joué!"
    when "false" || false || "non"
      return "Tout va bien !"
    when "je ne sais pas"
      return "Lorsque vous roulerez avec votre vélo, testez les freins progressivement, et voyez leur réaction. S’ils grincent, revenez ici et regardez nos conseils pour en parfaire les réglages."
    end
  end
end
