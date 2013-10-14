module Actions
  class Echo
    def matcher
      /\Aecho (.*)\z/
    end

    def action(matches, output)
      output.write "#{matches[1]}"
    end
  end
end
