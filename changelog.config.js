module.exports = {
    disableEmoji: false,
    format: '{emoji}{type}: {subject}',
    list: ['chore', 'ci', 'docs', 'feat', 'fix', 'init', 'perf', 'refactor', 'release', 'remove', 'style', 'test', 'upgrade'],
    maxMessageLength: 64,
    minMessageLength: 3,
    questions: ['type', 'subject', 'body', 'issues', 'lerna'],
    scopes: [],
    types: {
      chore: {
        description: 'Other chores.',
        emoji: '🔧',
        value: 'chore'
      },
      ci: {
        description: 'Continuous Integration changes.',
        emoji: '💚',
        value: 'ci'
      },
      docs: {
        description: 'Documentation only changes.',
        emoji: '📝',
        value: 'docs'
      },
      feat: {
        description: 'Introduce new features.',
        emoji: '🚀',
        value: 'feat'
      },
      fix: {
        description: 'Fix an error or a bug.',
        emoji: '🐛',
        value: 'fix'
      },
      init: {
        description: 'Initial commit.',
        emoji: '🌱',
        value: 'init'
      },
      perf: {
        description: 'Improve performance.',
        emoji: '⚡️',
        value: 'perf'
      },
      refactor: {
        description: 'Refactor codes.',
        emoji: '💡',
        value: 'refactor'
      },
      release: {
        description: 'Release a new version.',
        emoji: '🎉',
        value: 'release'
      },
      remove: {
        description: 'Remove codes/files.',
        emoji: '🔥',
        value: 'remove'
      },
      style: {
        description: 'Add or Update styles/animations.',
        emoji: '🎨',
        value: 'style'
      },
      test: {
        description: 'Begin a project.',
        emoji: '✅',
        value: 'test'
      },
      upgrade: {
        description: 'Upgrade SDKs or libraries.',
        emoji: '📦️',
        value: 'upgrade'
      }
    },
    messages: {
      type: 'Select the type of change that you\'re committing:',
      subject: 'Write a short, imperative mood description of the change:\n',
      body: 'Provide a longer description of the change:\n ',
      footer: 'Issues this commit closes, e.g #123:',
      confirmCommit: 'The packages that this commit has affected\n',
    }
  };
  