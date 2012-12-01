  jQuery(function($){
    SyntaxHighlighter.config.tagName = 'code';
    SyntaxHighlighter.all();

      $("#twwets").tweet({
					avatar_size: 48,
          // username: ["thijsvdlaar", "bramdenteuling", "dreamyourweb", "lvandewall", "jelmerwolterink", "logmaor"],
          query: "(from:dreamyourweb) OR (from:thijsvdlaar) OR (from:bramdenteuling) OR (from:lvandewall) OR (from:Andreslamont)",
          count: 2,
          loading_text: "Tweets laden..."
      });
  }).bind("loaded", function(){
      $(this).find("a.tweet_action").click(function(ev) {
        window.open(this.href, "Retweet",
                    'menubar=0,resizable=0,width=550,height=420,top=200,left=400');
        ev.preventDefault();
      });
});