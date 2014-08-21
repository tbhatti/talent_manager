class AddressesController < ApplicationController
  layout "home"
  def edit
    @address = Address.find(params[:id])
  end
  def update
    @address = Address.find(params[:id])
    respond_to do |format|
      if @address.update_attributes(params[:address])

        format.html { redirect_to  root_path,  notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

end
