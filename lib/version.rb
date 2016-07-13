class Version < String

  VERSION_REGEX = /\A\d+\.\d+\.\d+(-rc\d+)?\z/.freeze
  RELEASE_REGEX = /\A(\d+\.\d+\.)(\d+)\z/.freeze

  def milestone_name
    to_minor
  end

  def patch?
    patch > 0
  end

  def major
    return 0 unless version?

    @major ||= /\A(\d+)\./.match(self)[1].to_i
  end

  def minor
    return 0 unless version?

    @minor ||= /\A\d+\.(\d+)/.match(self)[1].to_i
  end

  def patch
    return 0 unless release?

    @patch ||= /\.(\d+)$/.match(self)[1].to_i
  end

  def rc
    self.match(/-(rc\d+)?\z/).captures.first if rc?
  end

  def rc?
    self =~ /\A\d+\.\d+\.\d+-rc\d+?\z/
  end

  def version?
    self =~ VERSION_REGEX
  end

  def release?
    self =~ RELEASE_REGEX
  end

  def previous_patch
    return unless patch?

    captures = self.match(RELEASE_REGEX).captures

    "#{captures[0]}#{patch - 1}"
  end

  def next_patch
    return unless release?

    captures = self.match(RELEASE_REGEX).captures

    "#{captures[0]}#{patch + 1}"
  end

  def stable_branch()
    to_minor.gsub('.', '-') <<
      '-stable'
  end

  def tag
    tag_for(self)
  end

  def previous_tag()
    return unless patch?

    tag_for(previous_patch)
  end

  def to_minor
    self.match(/\A\d+\.\d+/).to_s
  end

  def to_patch
    self.match(/\A\d+\.\d+\.\d+/).to_s
  end

  def to_rc(number = 1)
    "#{to_patch}-rc#{number}"
  end

  def valid?
    release? || rc?
  end

  private

  def tag_for(version)
    str = "v#{version}"

    str
  end
end
