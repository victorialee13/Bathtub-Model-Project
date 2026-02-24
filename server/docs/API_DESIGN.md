# Bathtub Models API – Design (not implemented)

Privacy rule: the API **never** accepts or returns raw GPS coordinates. Only anonymized relative trajectory data and zone metadata.

Base path: `/api`.

---

## 1. Upload (relative trajectories)

**POST** `/api/upload/relative-trajectories`

- **Purpose:** Mobile app submits one or more anonymized relative trajectory payloads. No lat/lng.
- **Request body:**
  - `trajectories`: array of relative trajectory items (see schema below).
- **Response:** `201 Created`
  - Body: `{ "accepted": <count>, "rejected": <count>, "ids": [ "<id>", ... ] }` (or similar; TBD).
- **Errors:** `400` invalid payload, `422` validation error.

**Relative trajectory item (schema):**

- `id` (string, optional): client-generated id for idempotency or dedup.
- `created_at` (string, ISO 8601): when the trajectory was recorded (client clock).
- `events` (array): list of relative trajectory events (e.g. zone/segment + duration or counts). No coordinates.
- No fields for latitude, longitude, or device/user identifiers in the payload.

---

## 2. Zones

**GET** `/api/zones`

- **Purpose:** List zone metadata (e.g. for map display or app config). No user location.
- **Query (optional):** `bbox` (min_lon,min_lat,max_lon,max_lat) or `format=geojson` – TBD.
- **Response:** `200 OK`
  - Body: list of zone objects (id, name, geometry or ref, tariff/congestion metadata if any). Exact shape TBD.
- **Errors:** `400` invalid query.

**GET** `/api/zones/{zone_id}`

- **Purpose:** Single zone by id.
- **Response:** `200 OK` – one zone object; `404` if not found.

---

## 3. Health / readiness (optional)

**GET** `/api/health` or `/health`

- **Response:** `200 OK` – e.g. `{ "status": "ok" }`.
- No sensitive data.

---

## Out of scope (by design)

- No endpoint accepts raw GPS points or full trajectories with coordinates.
- No endpoint returns user locations or raw trajectories.
- Authentication/authorization and rate limits are left for later.

---

## Implementation status

- Routes and Pydantic models are defined so the contract appears in OpenAPI (`/docs`).
- Handlers are stubs only; no persistence or business logic yet.
