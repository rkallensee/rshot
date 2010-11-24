# Hack for Paperclip which broke in Rails 3.0.3, see
# https://github.com/thoughtbot/paperclip/issues/issue/346

if defined? ActionDispatch::Http::UploadedFile
  ActionDispatch::Http::UploadedFile.send(:include, Paperclip::Upfile)
end
