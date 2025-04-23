import "dotenv/config"
import type {Config} from "drizzle-kit"

export default{
    schema:"./db/schema.ts",
    dialect: "postgresql",
    out:"./drizzle",
    dbCredentials:{
        url: "postgresql://neondb_owner:npg_wIxMlXFqGf70@ep-shiny-cake-a86k9f4d-pooler.eastus2.azure.neon.tech/neondb?sslmode=require",
    },
} satisfies Config;