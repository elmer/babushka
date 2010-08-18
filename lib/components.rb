module Babushka
  ExternalComponents = %w[
    fancypath/fancypath
  ]

  Components = %w[
    core_patches
    xml_string
    utils
    logger
    popen
    prompt_helpers
    shell
    shell_helpers
    suggest_helpers
    git_helpers
    resource
    lambda_chooser
    ip
    version_str
    version_of
    version_list
    colorizer
    levenshtein
    structs
    cmdline
    base
    system_spec
    bug_reporter
    pkg_helper
    pkg_helpers/base_helper
    pkg_helpers/apt_helper
    pkg_helpers/yum_helper
    pkg_helpers/brew_helper
    pkg_helpers/gem_helper
    pkg_helpers/macports_helper
    pkg_helpers/src_helper
    dep
    dep_pool
    meta_dep_pool
    definer_helpers
    task
    source
    source_pool
    dep_runner
    dep_runners/base_dep_runner
    dep_runners/meta_dep_runner
    dep_definer
    dep_definers/meta_dep_wrapper
    dep_definers/base_dep_definer
    dep_definers/meta_dep_definer
  ]
end