class RemoveReferenceFromCommentToUser < ActiveRecord::Migration
  def up
    remove_index :comments, :user_id
    remove_column :comments, :user_id
  end

  def down
    create_column :comments, :user_id, :integer, :references => "users"
    add_index :comments, :user_id

    # if migrating from a running version, migrate references from profiles to users.
    Comment.all.each do |comment|
      if comment.respond_to? :profile
        comment.user_id = comment.profile.user.id
        comment.save
      end
    end
  end
end
