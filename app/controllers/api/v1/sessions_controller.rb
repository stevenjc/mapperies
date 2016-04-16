class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = authenticate(params)

    sign_in(user) do |status|
      respond_to do |format|
        if status.success?
          self.current_user = user
          format.json{
             render(
                json: Api::V1::SessionSerializer.new(user, root: false).to_json,
                status: 201
              )
          }
        else
          format.json { render json: [errors: status.failure_message], status: :unauthorized }
        end
      end
    end
  end

  def destroy
    sign_out
  end
end
