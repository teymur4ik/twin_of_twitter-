class CommentsController < ApplicationController

  # создание комментария (нахождение id поста, создание, перенаправление на пост)
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(user_id: session[:user_id], body: comment_params[:body])
    redirect_to post_path(@post)
  end

  # показать комментарий, добавить возможность его удалить, перенаправление на пост
  def show
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
  
  private # метод может использоваться только в этом классе

  # дать доступ к body
  def comment_params
    params.required(:comment).permit(:body)
  end

end
