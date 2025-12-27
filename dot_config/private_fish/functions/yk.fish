function yk
    set query $argv[1]

    # Check if YubiKey is connected
    if not ykman list 2>/dev/null | grep -q "YubiKey"
        echo "Error: No YubiKey detected"
        return 1
    end

    if test -z "$query"
        # No argument - show all accounts with cleaned up formatting
        ykman oath accounts code 2>/dev/null | while read -l line
            if string match -qr '^(.+?):(.+?)\s+(\d{6,8})$' $line
                set -l m (string match -r '^(.+?):(.+?)\s+(\d{6,8})$' $line)
                printf "%-20s %s\n" "$m[2]" "$m[4]"
            else if string match -qr '^(.+?):(.+?)\s+\[Requires Touch\]$' $line
                set -l m (string match -r '^(.+?):(.+?)\s+\[Requires Touch\]$' $line)
                printf "%-20s %s\n" "$m[2]" "[Touch Required]"
            else if string match -qr '^(.+)\s+(\d{6,8})$' $line
                # Handle accounts without colons
                set -l m (string match -r '^(.+)\s+(\d{6,8})$' $line)
                printf "%-20s %s\n" "$m[2]" "$m[3]"
            end
        end
        return 0
    end

    # Get all accounts and parse them inline
    set -l all_accounts (ykman oath accounts code 2>/dev/null | while read -l line
        # Extract account name and code
        if string match -qr '^(.+)\s+(\d{6,8})$' $line
            set -l m (string match -r '^(.+)\s+(\d{6,8})$' $line)
            echo "$m[2]|$m[3]"
        else if string match -qr '^(.+)\s+\[Requires Touch\]$' $line
            set -l m (string match -r '^(.+)\s+\[Requires Touch\]$' $line)
            echo "$m[2]|TOUCH"
        end
    end)

    # Find matches
    set -l query_lower (string lower $query)
    set -l matches
    
    for line in $all_accounts
        set -l parts (string split '|' $line)
        set -l name $parts[1]
        set -l code $parts[2]
        
        # Case-insensitive matching
        if string match -qi "*$query_lower*" $name
            set -a matches "$name|$code"
        end
    end

    # Handle results
    if test (count $matches) -eq 0
        # No matches - show error and all accounts
        echo "Error: No match found for '$query'"
        echo ""
        echo "Available accounts:"
        ykman oath accounts code 2>/dev/null | while read -l line
            if string match -qr '^(.+?):(.+?)\s+(\d{6,8})$' $line
                set -l m (string match -r '^(.+?):(.+?)\s+(\d{6,8})$' $line)
                printf "%-20s %s\n" "$m[2]" "$m[4]"
            else if string match -qr '^(.+?):(.+?)\s+\[Requires Touch\]$' $line
                set -l m (string match -r '^(.+?):(.+?)\s+\[Requires Touch\]$' $line)
                printf "%-20s %s\n" "$m[2]" "[Touch Required]"
            else if string match -qr '^(.+)\s+(\d{6,8})$' $line
                set -l m (string match -r '^(.+)\s+(\d{6,8})$' $line)
                printf "%-20s %s\n" "$m[2]" "$m[3]"
            end
        end
        return 1
    else if test (count $matches) -eq 1
        # Single match - copy code and show success with improved formatting
        set -l parts (string split '|' $matches[1])
        set -l name $parts[1]
        set -l code $parts[2]
        
        if test "$code" = "TOUCH"
            # Handle touch-required accounts
            echo "Touch your YubiKey for: $name"
            set code (ykman oath accounts code "$name" -s 2>/dev/null)
        end
        
        # Format output: "✓ Amazon - icloud" instead of "✓ Copied code for: Amazon:icloud"
        set -l display_name (string replace ':' ' - ' $name)
        echo $code | pbcopy
        echo "✓ $display_name"
        return 0
    else
        # Multiple matches - show them
        echo "Multiple matches found:"
        for match in $matches
            set -l parts (string split '|' $match)
            set -l display_name (string replace ':' ' - ' $parts[1])
            echo "  $display_name"
        end
        return 1
    end
end
