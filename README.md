# NamOS Trainer

Multi-rate conditioning trainer for NAM (Neural Amp Modeler) models.

## What It Does

- Takes pre-trained 1-channel `.nam` models
- Expands them to 2-channel (audio + sample rate conditioning)
- Fine-tunes at 96kHz and 192kHz for better high-sample-rate performance
- Exports `.namos` files (NamOS format)

## Files

- **`NamOS_Trainer.ipynb`** — Google Colab notebook with interactive training
- **`netlify/`** — Static landing page for Netlify deployment
- **`setup.sh`** — One-click setup script

## Quick Setup (3 Steps)

### 1. Authenticate GitHub CLI

Open Terminal and run:
```bash
gh auth login --web
```
Follow the browser prompt to authenticate.

### 2. Run the Setup Script

```bash
cd /Users/juniper/Documents/OG\ NAM/NeuralAmpModelerPlugin-V1\ copy/NamOS-Trainer
./setup.sh
```

This will:
- Create the GitHub repo
- Update the Colab link with your username
- Push everything

### 3. Deploy to Netlify

1. Go to [netlify.com/drop](https://netlify.com/drop)
2. Drag the `netlify/` folder onto the page
3. Get a live URL instantly

**Or for auto-deploy on every push:**
1. Sign up at [netlify.com](https://netlify.com)
2. "Add new site" → "Import an existing project"
3. Select your GitHub repo
4. Set publish directory to `netlify/`

## Using the Notebook

1. Click "Open in Google Colab" from the landing page
2. Runtime → Change runtime type → GPU (T4 recommended)
3. Run cells in order:
   - Install dependencies
   - Upload DI, pre-trained .nam models, and capture .wav files
   - Adjust hyperparameters (sliders)
   - Train
   - Download results

## Required Files

- **DI** (`input.wav`) — Dry input signal used for all captures
- **Pre-trained models** (`.nam`) — Standard NAM WaveNet models
- **Captures** (`.wav`) — Reamp recordings matching each model

## Hyperparameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| Epochs | 200 | Training iterations per model |
| Patience | 30 | Early stopping patience (epochs) |
| Learning Rate | 0.0001 | Adam optimizer learning rate |
| Batch Size | 64 | Samples per batch |
| Chunk Size | 8192 | Audio samples per training chunk |
| Val Frequency | 5 | Validate every N epochs |

## Custom Domain (Optional)

**Yes, you can add a custom domain later.**

1. Go to Netlify → Site settings → Domain management
2. Click "Add custom domain"
3. Enter your domain (e.g., `trainer.tonkraf.com`)
4. Netlify gives you DNS records to add at your domain registrar
5. Or use Netlify DNS (easier) — just change your domain's nameservers to Netlify's

**Costs:**
- Netlify free tier: $0
- Custom domain: ~$10-15/year (Namecheap, Cloudflare, etc.)
- Netlify doesn't charge for custom domains on free tier

## Output

- `.namos` files in `output/` folder
- Zipped download: `NamOS_models.zip`

## Notes

- Models are matched by filename stem (without `_in_X_out_Y` suffix)
- Training uses GPU if available (T4 on Colab free tier)
- Each model is trained independently (batch processing)
- The Phoenix plugin will eventually support `.namos` files

## Support

Made by [Tonkraf](https://www.tonkraf.com) · Built on [NAM](https://github.com/sdatkinson/NeuralAmpModeler)
