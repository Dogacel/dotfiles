zsh_llm_suggestions_spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'

    cleanup() {
      kill $pid
      echo -ne "\e[?25h"
    }
    trap cleanup SIGINT
    
    echo -ne "\e[?25l"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b"
    done
    printf "    \b\b\b\b"

    echo -ne "\e[?25h"
    trap - SIGINT
}

zsh_llm_suggestions_run_query() {
  local result_file=$1
  local query=$2

  [ -e "$result_file" ] && rm $result_file 

  local question="
Answer the following question by only outputing a shell comand.
Don't do any formatting, don't wrap it with markdown, never answer any question.
The output should be directly executable in shell with a simple copy paste.
Don't include ; at the end unless absolutely needed. Don't use markdown to format the script.
Don't include any text that will err the command line. Here is the question:

'$query'
" 

  if [ -n "$LLM_SESSION_ID" ]; then
    llm -c "$question" >> $result_file
  else
    llm "$question" >> $result_file
  fi
}

function pipe_to_llm() {
  # Check if the buffer starts with '#'
  if [[ "$BUFFER" == '# '* ]]; then
    # Save buffer to history
    print -s -- "$BUFFER"

    # Remove the '#' and any leading whitespace from the remainder
    local text="${BUFFER#\#}"
    text="${text##*( )}"  # Trim any leading spaces
    
    # Temporary file to store the result of the background process
    local result_file="/tmp/zsh-llm-suggestions-result"
    # Run the actual query in the background (since it's long-running, and so that we can show a spinner)
    
    read < <( zsh_llm_suggestions_run_query $result_file $text & echo $! )
    # Get the PID of the background process
    local pid=$REPLY
    # Call the spinner function and pass the PID
    zsh_llm_suggestions_spinner $pid

    export LAST_SUGGESTED_COMMAND=$(cat $result_file)
    export LLM_SESSION_ID=$(llm logs | grep '^#' | grep 'conversation:' | tail -n 1 | awk -F 'id: ' '{print $2}')
    BUFFER=$LAST_SUGGESTED_COMMAND
    # Redisplay the line so that it shows up for editing rather than executing
    zle redisplay
  else
    # Otherwise, behave like the normal Enter (accept-line)
    zle accept-line
  fi
}

# Register the widget with ZLE
zle -N pipe_to_llm 

# Bind the Enter key (usually represented as ^M) to our widget
bindkey '^M' pipe_to_llm 


