class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show]

    def index
        @posts = Post.all
    end
    def show
        @post = Post.find(params[:id])
        
        @comments = @post.comments.all
        @comment = @post.comments.build
    end

    def new
        @post = current_user.posts.build
    end
    
    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(params.require(:post).permit(:title, :text))

        if @post.save
        redirect_to @post
        else
            render 'new'
    end
end


    
    
    
    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to posts_path
    end
    
    private
    def require_login
        unless logged_in?
            flash[:error] = "Hey! You Have to Sign In!"
            redirect_to new_login_url
        end
    end
    def post_params
        params.require(:post).permit(:title, :text)
    end

end

