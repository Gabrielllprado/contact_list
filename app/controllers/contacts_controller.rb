class ContactsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_contact, only: [:show, :edit, :update]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = current_user.contacts.build(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to user_contacts_path, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    @contact = current_user.contacts.find(params[:id])
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to user_contacts_path, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = current_user.contacts.find(params[:id])
    if @contact.destroy
      flash[:success] = 'Contato removido com sucesso'
      redirect_to user_contacts_path
    else
      flash[:danger] = 'Contato não encontrado.'
      redirect_to user_contacts_path(current_user)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :phone)
    end
end
