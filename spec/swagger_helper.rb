require "rails_helper"

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + "/swagger"

  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "API Agendamento Educacional",
        version: "v1",
        description: "Documentação da API."
      },
      paths: {},
      servers: [
        {
          url: "http://{defaultHost}",
          variables: {
            defaultHost: {
              default: "localhost:3000"
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          Bearer: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT,
            description: "Cole seu token aqui (sem a palavra Bearer)"
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
