# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

    Article.destroy_all
    User.destroy_all

    User.create!({
        email: "nelson.haha@gmail.com",
        name: "Nelson Muntz",
        password: "colección-de-estampas-haha",
        username: "nmuntz"
    })
    Article.create!([{
        title: "Festival de cine",
        description: "Frame de mi cortometraje en el festival de Sundance",
        image_url: "https://i.ytimg.com/vi/qt65_GTEVBI/hqdefault.jpg"
    }, {
        title: "¿Será posible?",
        description: "",
        image_url: "https://preview.redd.it/yt1sqo8q1s911.jpg?width=640&crop=smart&auto=webp&s=47eefcc90981bfcdc88356098271821f198646bc"
    }])
