require "rails_helper"

class ExampleModel
  include ActiveModel::Model

  attr_accessor :email

  validates :email, email: true
end

RSpec.describe EmailValidator do
  subject { ExampleModel.new }

  describe "invalid email validation" do
    it "should validate with errors" do
      [
        1.2,
        1,
        "email",
        "müller@example.com",
        "mÜller@example.net",
        "test@example.com..",
        "comma,@example.com",
        "commA,@Example.com",
        "$%^&@$%^&.com",
      ].each do |email|
        subject.email = email
        expect(subject).to_not be_valid
      end
    end
  end

  describe "valid email validation" do
    it "should validate all godaddy TLD" do
      %w(
        abudhabi
        academy
        accountant
        accountants
        active
        actor
        ads
        adult
        africa
        agency
        airforce
        alsace
        amsterdam
        analytics
        apartments
        app
        aquitaine
        arab
        archi
        architect
        army
        art
        arte
        associates
        attorney
        auction
        audible
        author
        auto
        autos
        baby
        band
        bank
        banque
        bar
        barcelona
        bargains
        baseball
        basketball
        bayern
        beauty
        beer
        beknown
        berlin
        best
        bet
        bible
        bid
        bike
        bingo
        bio
        black
        blog
        blue
        boats
        book
        booking
        boston
        bot
        boutique
        box
        broadway
        broker
        brussels
        budapest
        build
        builders
        business
        buy
        buzz
        bzh
        cab
        cafe
        call
        cam
        camera
        camp
        capetown
        capital
        car
        cards
        care
        career
        careers
        cars
        casa
        case
        cash
        cashbackbonus
        casino
        catering
        catholic
        center
        ceo
        cfd
        charity
        chat
        cheap
        church
        city
        cityeats
        claims
        cleaning
        clinic
        clothing
        cloud
        club
        co
        coach
        codes
        coffee
        college
        cologne
        com
        community
        company
        compare
        computer
        comsec
        condos
        construction
        consulting
        contact
        contractors
        cooking
        cool
        corsica
        country
        coupon
        coupons
        courses
        cpa
        credit
        creditcard
        cricket
        cruise
        cruises
        cymru
        dad
        dance
        data
        date
        dating
        dds
        deal
        dealer
        deals
        degree
        delivery
        democrat
        dental
        dentist
        design
        dev
        diamonds
        digital
        direct
        directory
        discount
        diy
        docs
        doctor
        dog
        doha
        domains
        dot
        download
        drive
        dubai
        durban
        earth
        eat
        eco
        ecom
        edu
        education
        email
        energy
        engineer
        engineering
        enterprises
        equipment
        esq
        estate
        eus
        events
        exchange
        expert
        exposed
        express
        fail
        faith
        family
        fan
        fans
        farm
        fashion
        feedback
        film
        finance
        financial
        financialaid
        fish
        fishing
        fit
        fitness
        flights
        florist
        food
        football
        forsale
        forum
        foundation
        free
        fun
        fund
        furniture
        futbol
        fyi
        gallery
        games
        garden
        gay
        ged
        gent
        gifts
        gives
        giving
        glass
        gle
        global
        gmbh
        gold
        golf
        graphics
        gratis
        green
        gripe
        grocery
        group
        guide
        guru
        hair
        halal
        hamburg
        haus
        health
        healthcare
        helsinki
        here
        hockey
        holdings
        holiday
        homes
        horse
        hospital
        host
        hoteis
        hotel
        hoteles
        hotels
        house
        imamat
        immo
        immobilien
        inc
        indians
        industries
        info
        ink
        institute
        insurance
        insure
        international
        investments
        ira
        irish
        islam
        ismaili
        ist
        istanbul
        jetzt
        jewelry
        joburg
        kaufen
        kid
        kids
        kim
        kinder
        kitchen
        kiwi
        koeln
        kyoto
        land
        lat
        latino
        lawyer
        lease
        legal
        lgbt
        life
        lifeinsurance
        lifestyle
        lighting
        limited
        limo
        live
        living
        llc
        llp
        loan
        loans
        london
        lotto
        love
        ltd
        ltda
        luxe
        luxury
        madrid
        mail
        maison
        management
        map
        market
        marketing
        markets
        mba
        me
        med
        media
        medical
        melbourne
        memorial
        men
        menu
        miami
        mil
        mls
        mobile
        moda
        moe
        money
        mortgage
        moscow
        motorcycles
        mov
        movie
        movistar
        music
        mutual
        mutualfunds
        nagoya
        navy
        net
        network
        new
        news
        ngo
        ninja
        nrw
        nyc
        okinawa
        one
        onl
        online
        org
        organic
        osaka
        page
        paris
        partners
        parts
        party
        pay
        persiangulf
        pet
        pets
        pharmacy
        phd
        phone
        photography
        photos
        physio
        pictures
        pink
        pizza
        plumbing
        plus
        poker
        porn
        press
        prime
        Pro
        productions
        prof
        promo
        properties
        Protection
        pub
        pw
        qpon
        quebec
        racing
        radio
        realestate
        realtor
        recipes
        red
        rehab
        reise
        reisen
        reit
        ren
        rent
        rentals
        repair
        report
        republican
        rest
        restaurant
        retirement
        review
        reviews
        rich
        rio
        rip
        rocks
        rodeo
        roma
        room
        rsvp
        rugby
        run
        ryukyu
        saarland
        sale
        salon
        sarl
        save
        scholarships
        school
        schule
        science
        scot
        search
        seat
        secure
        security
        services
        sex
        shia
        shiksha
        shoes
        shop
        shopping
        show
        silk
        singles
        site
        ski
        soccer
        social
        software
        solar
        solutions
        song
        soy
        spa
        space
        sport
        sports
        spreadbetting
        srl
        stockholm
        storage
        store
        stream
        studio
        study
        style
        sucks
        supplies
        supply
        support
        surf
        surgery
        swiss
        sydney
        systems
        taipei
        tax
        taxi
        team
        tech
        technology
        Tel
        tennis
        thai
        theater
        theatre
        tickets
        tienda
        tips
        tires
        tirol
        today
        tokyo
        tools
        top
        tour
        tours
        town
        toys
        trade
        trading
        training
        translations
        travel
        trust
        tube
        tunes
        university
        uno
        us
        vacations
        vegas
        ventures
        vet
        viajes
        video
        villas
        vin
        vip
        vision
        vlaanderen
        vodka
        vote
        voto
        voyage
        wales
        wang
        wanggou
        watch
        watches
        web
        webcam
        webs
        website
        wed
        wedding
        weibo
        wien
        wiki
        win
        wine
        work
        works
        world
        wtf
        xin
        xyz
        yoga
        yokohama
        yun
        zip
        zone
      ).each do |tld|
        subject.email = "jane.doe@example.#{tld}"
        expect(subject).to be_valid
      end
    end
  end
end
