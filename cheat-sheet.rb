rails g scaffold Post title:string description:text content:text

#breites Bild
rails g scaffold Post title:string description:text content:text --cover_display section

#Bild oben
rails g scaffold Page title:string description:text content:text --cover_display top

rails g add_cover Post

rails g tinymce Post

rails g tinymce Post --name_of_attribute content

rails g add_search_field Post

rails g add_many_to_many_relationship  Account --model slide
rails g add_many_to_many_relationship  Account --model option


<section class="page-cover-bg" style="background-image: url('<%%= url_cover %>'); height: <%%= height_of_cover %>px;">
    <div class="container d-flex align-items-start justify-content-center h-100 pt-2">

        <%%#= image_tag("logo_stinah_ws_vektor.png", class: "img-fluid mb-4 rounded overlay-darker", style: "height: 180px;") %>

    </div>
</section>

"https://player.vimeo.com/video/334631596?muted=1&amp;autoplay=1&amp;loop=1&amp;title=0&amp;byline=0&amp;portrait=0"

Submission.all.each_with_index do |sub, index|
  sub.update(appearance_date: Date.today - index.weeks)
end

Submissian.all.each do |sub|
  sub.update(appearance_date: sub.created_at.to_date)
end

Submission.find_each(&:save)
