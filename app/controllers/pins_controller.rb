class PinsController < ApplicationController
     before_action :set_pin, only: [:show, :edit, :update, :destroy, :mispins]
     before_action :authenticate_user!, except: [:index, :show, :mispins]
     before_action :correct_user, only: [:edit, :update, :destroy, :mispins]

       respond_to :html

       def index
           @pins = Pin.all
        end

       def show
         @pin = Pin.find(params[:id])
         @comments = @pin.comments.all
         @comment = @pin.comments.build
         end

       def new
          @pin = current_user.pins.build
       end

       def mispins
          @pins = Pin.all
          @pin = current_user.pins.build
       end

       def edit
       end


     def upvote
       @pin = Pin.find(params[:id])
       @pin.upvote_by current_user
       redirect_to pins_path
     end


     def downvote
       @pin = Pin.find(params[:id])
       @pin.downvote_by current_user
       redirect_to pins_path
     end



     def create
           @pin = current_user.pins.build(pin_params)
    if @pin.save
            redirect_to @pin, notice: 'Pin was successfully created.'
          else
            render action: 'new'
    end
       end

     def update
        if @pin.update(pin_params)
           redirect_to @pin, notice: 'Pin was successfully updated.'
         else
           render action: 'edit'
        end
     end

     def destroy
         @pin.destroy
         redirect_to pins_url
       end



     private
       def set_pin
           @pin = Pin.find(params[:id])
         end

     def pin_params
            params.require(:pin).permit(:image,:description)
     end

     def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
        redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
     end




 end
