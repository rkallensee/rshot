class MakeCommentReferenceProfile < ActiveRecord::Migration
  def up
    add_column :comments, :profile_id, :integer, :references => "profiles"
    add_index :comments, :profile_id

    # if migrating from a running version, migrate references.
    Comment.all.each do |comment|
      if comment.respond_to? :user
        comment.profile_id = comment.user.profile.id
        comment.save
      end
    end
  end

  def down
    remove_index :comments, :profile_id
    remove_column :comments, :profile_id
  end
end
