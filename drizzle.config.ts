import "dotenv/config"
import type {Config} from "drizzle-kit"

export default{
    schema:"./db/schema.ts",
    dialect: "postgresql",
    out:"./drizzle",
    dbCredentials:{
        url: "postgresql://neondb_owner:npg_rymCafI5X7Qd@ep-shrill-dream-a84lpy17-pooler.eastus2.azure.neon.tech/neondb?sslmode=require",
    },
} satisfies Config;