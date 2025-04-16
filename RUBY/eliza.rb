#! /usr/bin/ruby -w

# Represents a Rogerian psychiatrist
class Shrink
    def initialize()
      @he = "he"
      @she = "she"
      @they = "they"  # New memory for "they"
    end
  
    # Generate a psychiatric response
    def generateResponse(blather)
      original = blather.dup
      blather = blather.downcase.strip
  
      # Filter out "Well", "Perhaps", etc.
      blather.sub!(/^(well|perhaps|maybe|also)\b[\s,]*/i, '')
  
      # Respond to "Are you" type questions
      if blather =~ /\A(are you\b.*)\?*/
        return "IS IT IMPORTANT IF I AM #{original.strip.upcase}?"
      end
  
      # Respond to vague terms
      if blather =~ /\b(always|never|every time|constantly)\b/
        return "CAN YOU BE MORE SPECIFIC?"
      end
  
      # Human-like touch: respond to "I'm feeling [emotion]"
      if blather =~ /\bi'?m feeling (\w+)\b/
        return "WHY DO YOU THINK YOU FEEL #{$1.upcase}?"
      end
  
      # Pronoun swapping
      blather.gsub!(/\byour\b/, "MY")
      blather.gsub!(/\byou\b/, 'I')
      blather.gsub!(/\bmy\b/, "your")
      blather.gsub!(/\bme\b/, "you")
      blather.gsub!(/\bi\b/, 'you')
  
      # Past reference substitution
      blather.sub!(/\b(he|him)\b/, @he)
      blather.sub!(/\b(she|her)\b/, @she)
      blather.sub!(/\b(they|them)\b/, @they)
  
      # Update memory references
      hePat = /.*\b(your (father|brother|(ex-?)?(husband|boyfriend)))\b.*/
      shePat = /.*\b(your (mother|sister|(ex-?)?(wife|girlfriend)))\b.*/
      theyPat = /.*\b(your (friends|parents|siblings|teachers|coworkers|they))\b.*/
  
      @he = blather.sub(hePat, '\1').chomp if blather =~ hePat
      @she = blather.sub(shePat, '\1').chomp if blather =~ shePat
      @they = blather.sub(theyPat, '\1').chomp if blather =~ theyPat
  
      # Handle name
      namePat = /.*\byour name is (\w+).*/
      @name = blather.sub(namePat, '\1')
      blather.sub!(namePat, 'nice to meet you, \1. how can I help you')
  
      return blather.upcase + "?"
    end
  end
  
  # main -- reads from standard input unless -test is first parameter
  eliza = Shrink.new()
  if ARGV[0] == "-test"
    [
      'My girlfriend never listens to me',
      "I think she might be deaf",
      "yes",
      "I am afraid of clowns",
      "Well, they just seem creepy",
      "Also, when I was a kid, a clown killed my dad",
      "Are you a clown in disguise?",
      "I'm feeling anxious lately.",
      "Perhaps you don't understand",
      "My friends always ignore me",
      "Your name is Alex"
    ].each do |stmt|
        puts stmt
        puts eliza.generateResponse(stmt)
    end
  else
    while line = gets
        response = eliza.generateResponse line
        puts response
    end
  end
  