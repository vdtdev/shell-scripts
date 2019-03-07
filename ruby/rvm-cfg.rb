#!/usr/bin/env ruby
##
# RvmCfg - generates rvm config files (.ruby-version + .ruby-gemset)
# Usage:
# rvm-cfg ( <version[@gemset] ) | ( <version> [ <gemset> ] ) [--overwrite]
# @author Wade H (vdtdev.prod@gmail.com)
# @license MIT
# github.com/vdtdev
module RvmCfg
    extend self

    ## Run tool
    def run
        args = intercept_arg_switches
        names = process_args(args[:args])
        opts = options_from_switches(args[:switches])
        existing = check_for_existing
        # [args,names,opts]

        if names[:version].nil? && names[:gemset].nil?
            usage
        else
            if existing[:version] && !opts[:overwrite]
                cprintf "Ruby Version file already exists! Skipping\n", 31, 1
            else
                File.write(File.join(Dir.getwd,'.ruby-version'), names[:version])
                cprintf "Ruby Version file written (#{names[:version]})\n", 32
            end
            if !names[:gemset].nil?
                if existing[:gemset] && !opts[:overwrite]
                    cprintf "Gemset file already exists! Skipping\n", 31, 1
                else
                    File.write(File.join(Dir.getwd,'.ruby-gemset'), names[:gemset])
                    cprintf "Gemset file written (#{names[:gemset]})\n", 32
                end
            elsif opts[:overwrite]
                File.delete(File.join(Dir.getwd,'.ruby-gemset'))
                cprintf "No gemset name given and overwrite is ON-- deleted existing .ruby-gemset!\n", 33
            end
        end
    end

    private

    # Bash text color printf
    def cprintf(text,fg=37,bg=0)
        printf "\033[#{bg};#{fg}m#{text}\033[0;37m"
    end

    ##
    # Display usage info
    def usage
        printf "Usage: "
        cprintf "rvm-cfg ", 32
        cprintf "<ruby-version> [<gemset>] ", 36, 1
        cprintf "[options]\n", 35, 1
        printf "Parameters:\n"
        cprintf "\truby-version\t", 36, 1
        printf "Ruby version number, or version + gemset using version@gemset\n"
        cprintf "\tgemset\t\t", 36, 1
        printf "(Optional) Ruby gemset; only if version doesn't already include it\n"
        printf "Options:\n"
        cprintf "\t--overwrite (--o)\t", 35, 1
        printf "Overwrite existing config files (default is to skip existing)\n"
    end

    ##
    # Build options Hash from array of switch names
    # @param [Array] switches Enabled switches
    # @return [Hash] Options hash
    def options_from_switches(switches)
        {
            overwrite: (
                switches.include?('o') || 
                switches.include?('overwrite')
            )? true : false
        }
    end
    
    ##
    # Pull out switches (--x) from arg list, returning
    # hash with non switch args (args) and switch names (switches)
    # @return [Hash] filtered argument hash
    def intercept_arg_switches
        args = ARGV
        switches = args.select { |a| a.start_with?('--') }
        {
            args: args - switches,
            switches: switches.map{|s|s.gsub('--','')}
        }
    end

    ##
    # Extract/parse arguments, returning hash with version and gemset name
    # @param [Array] args Array of arguments
    # @return [Hash] Hash defining :version and :gemset
    def process_args(args)
        version,gemset = args
        args={version: version, gemset: gemset}
        if !version.nil? && gemset.nil? && version.include?("@")
            version,gemset = version.split("@")
            args = Hash[[:version,:gemset].zip([version,gemset])]
        end
        args
    end

    ##
    # @return [Hash] Hash with bools indicating if version and gemset files exist
    def check_for_existing
        p = Dir.getwd
        {
            version: File.exist?(File.join(p,'.ruby-version')),
            gemset: File.exist?(File.join(p,'.ruby-gemset'))
        }
    end

end


# Run tool
RvmCfg.run