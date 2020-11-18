module Urls
  class Create
    include Interactor

    NUMBER_CREATION_TRIES = 3

    delegate :params, to: :context

    def call
      url = create

      context.response = render_response(url)
    end

    private

    def render_response(url)
      if url.persisted?
        { short_version: url.short_version }
      else
        { errors: url.errors }
      end
    end

    def create
      url = Url.new(params.merge(short_version: generate_short_version))
      tries = 0

      begin
        tries += 1

        url.save

        url
      rescue ActiveRecord::RecordNotUnique
        url.validate

        if url.errors.keys == %i[short_version]
          url.short_version = generate_short_version

          tries == NUMBER_CREATION_TRIES ? raise : retry
        else
          url
        end
      end
    end

    def generate_short_version
      # I don't know the format, maybe full_version must have participant in
      # done usual generation
      SecureRandom.hex
    end
  end
end
