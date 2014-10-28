require 'spec_helper'

describe TodoListsController do

  # This should return the minimal set of attributes required to create a valid
  # TodoList. As you add validations to TodoList, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "title" => "MyString", "description" => "my description" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TodoListsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let!(:user) { create(:user) }

  before do 
    sign_in(user)
  end
      

  describe "GET index" do
    context "logged in" do
      it "assigns all todo_lists as @todo_lists" do
        todo_list = user.todo_lists.create! valid_attributes        
        get :index, {}, valid_session
        assigns(:todo_lists).should eq([todo_list])
        expect(assigns(:todo_lists).map(&:user)).to eq([user])
      end
    end
  end

  describe "GET show" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = TodoList.create! valid_attributes
      get :show, {:id => todo_list.to_param}, valid_session
      assigns(:todo_list).should eq(todo_list)
    end
  end

  describe "GET new" do
    it "assigns a new todo_list as @todo_list" do
      get :new, {}, valid_session
      assigns(:todo_list).should be_a_new(TodoList)
    end
  end

  describe "GET edit" do
    it "assigns the requested todo_list as @todo_list" do
      todo_list = TodoList.create! valid_attributes
      get :edit, {:id => todo_list.to_param}, valid_session
      assigns(:todo_list).should eq(todo_list)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TodoList" do
        expect {
          post :create, {:todo_list => valid_attributes}, valid_session
        }.to change(TodoList, :count).by(1)
      end

      it "assigns a newly created todo_list as @todo_list" do
        post :create, {:todo_list => valid_attributes}, valid_session
        assigns(:todo_list).should be_a(TodoList)
        assigns(:todo_list).should be_persisted
      end

      it "redirects to the created todo_list" do
        post :create, {:todo_list => valid_attributes}, valid_session
        response.should redirect_to(TodoList.last)
      end

      it "creates a todo list for the current user" do 
        post :create, {:todo_list => valid_attributes}, valid_session
        todo_list = TodoList.last
        expect(todo_list.user).to eq(user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved todo_list as @todo_list" do
        # Trigger the behavior that occurs when invalid params are submitted
        TodoList.any_instance.stub(:save).and_return(false)
        post :create, {:todo_list => { "title" => "invalid value" }}, valid_session
        assigns(:todo_list).should be_a_new(TodoList)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TodoList.any_instance.stub(:save).and_return(false)
        post :create, {:todo_list => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested todo_list" do
        todo_list = TodoList.create! valid_attributes
        # Assuming there are no other todo_lists in the database, this
        # specifies that the TodoList created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TodoList.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => todo_list.to_param, :todo_list => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
        assigns(:todo_list).should eq(todo_list)
      end

      it "redirects to the todo_list" do
        todo_list = TodoList.create! valid_attributes
        put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
        response.should redirect_to(todo_list)
      end
    end

    describe "with invalid params" do
      it "assigns the todo_list as @todo_list" do
        todo_list = TodoList.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TodoList.any_instance.stub(:save).and_return(false)
        put :update, {:id => todo_list.to_param, :todo_list => { "title" => "invalid value" }}, valid_session
        assigns(:todo_list).should eq(todo_list)
      end

      it "re-renders the 'edit' template" do
        todo_list = TodoList.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TodoList.any_instance.stub(:save).and_return(false)
        put :update, {:id => todo_list.to_param, :todo_list => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested todo_list" do
      todo_list = TodoList.create! valid_attributes
      expect {
        delete :destroy, {:id => todo_list.to_param}, valid_session
      }.to change(TodoList, :count).by(-1)
    end

    it "redirects to the todo_lists list" do
      todo_list = TodoList.create! valid_attributes
      delete :destroy, {:id => todo_list.to_param}, valid_session
      response.should redirect_to(todo_lists_url)
    end
  end

end
