# 10x Cards

A web application for quickly and effectively creating high-quality educational flashcards using artificial intelligence.

## Table of Contents

- [Project Description](#project-description)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Available Scripts](#available-scripts)
- [Project Scope](#project-scope)
- [Project Status](#project-status)
- [License](#license)

## Project Description

10x Cards solves the problem of time-consuming manual creation of flashcards, which often discourages users from using the effective spaced repetition learning method. This proof-of-concept application demonstrates that AI can significantly speed up and simplify the process of creating flashcards while maintaining high educational quality.

### Key Features

- AI-generated flashcards from pasted text
- Simple and intuitive user interface
- Integration with existing spaced repetition algorithm
- User account system ensuring data privacy
- Review and editing of AI-generated flashcards
- Manual creation and management of flashcards

## Tech Stack

### Frontend
- [Astro 5](https://astro.build/) - Fast, modern web framework
- [React 19](https://react.dev/) - For interactive components
- [TypeScript 5](https://www.typescriptlang.org/) - Static typing for better development experience
- [Tailwind 4](https://tailwindcss.com/) - Utility-first CSS framework
- [Shadcn/ui](https://ui.shadcn.com/) - Accessible React component library

### Backend
- [Supabase](https://supabase.com/) - Backend-as-a-Service solution
  - PostgreSQL database
  - SDK for multiple languages
  - Built-in user authentication

### AI Integration
- [Openrouter.ai](https://openrouter.ai/) - Access to various AI models for flashcard generation
  - Integration with OpenAI, Anthropic, Google models
  - Financial limit controls for API keys

### CI/CD and Hosting
- GitHub Actions - CI/CD pipelines
- DigitalOcean - Hosting via Docker image

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (see .nvmrc for version)
- npm or yarn

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/your-username/10x-cards.git
   cd 10x-cards
   ```

2. Install dependencies
   ```bash
   npm install
   ```

3. Create environment variables
   ```bash
   cp .env.example .env
   ```

4. Set up your environment variables in the `.env` file
   - Add your Supabase credentials
   - Add your Openrouter.ai API key

5. Start the development server
   ```bash
   npm run dev
   ```

6. Open your browser and navigate to `http://localhost:4321`

## Available Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the application for production
- `npm run preview` - Preview the production build locally
- `npm run astro` - Run Astro CLI commands
- `npm run lint` - Run ESLint to check for issues
- `npm run lint:fix` - Run ESLint and fix issues automatically
- `npm run format` - Format code with Prettier

## Project Scope

### What's Included in MVP
- User authentication (registration, login, logout)
- AI-generated flashcards from text input
- Manual flashcard creation, editing, and deletion
- Basic spaced repetition system
- Simple and intuitive user interface

### What's NOT in MVP
- Proprietary advanced spaced repetition algorithm
- Import of multiple file formats (PDF, DOCX, etc.)
- Flashcard sharing between users
- Integrations with other educational platforms
- Mobile applications (web version only)
- Usage statistics and analytics
- Monetization features (free product)

## Project Status

This project is currently in the proof-of-concept stage, with the goal of delivering a functional prototype within 6 weeks.

### Success Metrics

#### Product Metrics
- 75% of AI-generated flashcards are accepted by users without editing
- Users create 75% of their flashcards using the AI feature
- Average time to create a set of 10 flashcards is less than 5 minutes
- 70% of users use the repetition system at least once a week
- 60% of users return to the application after a week from first use

#### Technical Metrics
- API response time for flashcard generation: maximum 10 seconds for a set of 10 flashcards
- System availability: 99% uptime
- Average page load time: below 2 seconds
- System error rate: below 1%

## License

[MIT License](LICENSE) 